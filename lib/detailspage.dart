import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager_android.dart';

class Detailspage extends StatefulWidget {
  const Detailspage({super.key});

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage>
    with SingleTickerProviderStateMixin {
  bool _isCardTapped = false;
  bool _isScanning = false;
  String _cardNumber = "xxxx xxxx xxxx xxxx";
  String _cardType = "CARD";
  String _expiryDate = "xx/xx";
  String _cardHolder = "CARD HOLDER";
  String _errorMessage = "";

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startNfcSession() async {
    // Check if NFC is available
    NfcAvailability availability = await NfcManager.instance
        .checkAvailability();
    if (availability != NfcAvailability.enabled) {
      setState(() {
        _errorMessage = "NFC is not available on this device";
      });
      return;
    }

    setState(() {
      _isScanning = true;
      _errorMessage = "";
    });

    try {
      await NfcManager.instance.startSession(
        pollingOptions: {
          NfcPollingOption.iso14443,
        }, // You can also specify iso18092 and iso15693.
        onDiscovered: (NfcTag tag) async {
          // Do something with an NfcTag instance...
          print(tag);

          // Stop the session when no longer needed.
          await NfcManager.instance.stopSession();
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Error: ${e.toString()}";
        _isScanning = false;
      });
    }
  }

  // Helper methods

  List<int> _hexToBytes(String hex) {
    hex = hex.replaceAll(" ", "");
    List<int> bytes = [];
    for (int i = 0; i < hex.length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return bytes;
  }

  String _bytesToHex(List<int> bytes) {
    return bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
  }

  Future<String?> _tryCommonAids(dynamic nfcInterface) async {
    // List of common AIDs to try
    final aids = [
      "A0000000031010", // Visa
      "A0000000041010", // Mastercard
    ];

    for (var aid in aids) {
      try {
        List<int> aidBytes = _hexToBytes(aid);
        int aidLength = aidBytes.length;
        String aidLengthHex = aidLength.toRadixString(16).padLeft(2, '0');
        List<int> command = _hexToBytes("00A40400$aidLengthHex$aid");

        List<int> response = await nfcInterface.transceive(data: command);
        String responseHex = _bytesToHex(response);

        // 9000 indicates success
        if (responseHex.endsWith("9000")) {
          return aid;
        }
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  String? _findPan(String data) {
    // Basic regex for PAN (16-19 digits), usually tag 5A
    // This is a simplified search, real parsing should handle TLV properly
    RegExp panRegex = RegExp(r'5A08([0-9]{16})');
    var match = panRegex.firstMatch(data);
    if (match != null) {
      String rawPan = match.group(1)!;
      // Format as groups of 4
      return rawPan
          .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")
          .trim();
    }
    return null;
  }

  String? _findExpiry(String data) {
    // Basic regex for Expiry (YYMM), usually tag 5F24
    RegExp expiryRegex = RegExp(
      r'5F2403(\d{4})',
    ); // Sometimes 3 bytes with padding
    var match = expiryRegex.firstMatch(data);
    if (match == null) {
      expiryRegex = RegExp(r'5F2402(\d{4})'); // Or 2 bytes
      match = expiryRegex.firstMatch(data);
    }

    if (match != null) {
      String raw = match.group(1)!; // YYMM
      if (raw.length >= 4) {
        String year = raw.substring(0, 2);
        String month = raw.substring(2, 4);
        return "$month/$year";
      }
    }
    return null;
  }

  String? _findCardholderName(String data) {
    // Name is usually tag 5F20
    RegExp nameRegex = RegExp(r'5F20([0-9A-Fa-f]{2,})');
    var match = nameRegex.firstMatch(data);
    if (match != null) {
      // Decode hex to ASCII
      try {
        String hex = match.group(1)!;
        // The length byte is likely the first byte of the capture or we need to parse TLV better
        // Simplified: just try to decode the whole hex string until we hit non-printable
        List<int> bytes = _hexToBytes(hex);
        // Remove length byte if it looks like one (simple heuristic)
        if (bytes.isNotEmpty && bytes[0] == bytes.length - 1) {
          bytes = bytes.sublist(1);
        }

        String name = String.fromCharCodes(
          bytes.where((b) => b >= 32 && b <= 126),
        );
        if (name.length > 2) return name.trim();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Card Reader'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isCardTapped) ...[
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F69E7).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isScanning ? Icons.sync : Icons.contactless_outlined,
                      size: 100,
                      color: const Color(0xFF0F69E7),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  _isScanning
                      ? 'Hold card near device...'
                      : 'Tap to scan your card',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isScanning ? null : _startNfcSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F69E7),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isScanning ? 'Scanning...' : 'Start NFC Scan',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isCardTapped = true;
                      _cardNumber = "4512 8888 7777 6234";
                      _cardType = "VISA";
                      _expiryDate = "12/28";
                      _cardHolder = "JOHN DOE";
                    });
                  },
                  child: const Text("Demo Mode (Test UI)"),
                ),
              ] else ...[
                _buildCreditCard(),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isCardTapped = false;
                      _cardNumber = "xxxx xxxx xxxx xxxx";
                      _cardType = "CARD";
                      _expiryDate = "xx/xx";
                      _cardHolder = "CARD HOLDER";
                      _errorMessage = "";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Scan Another Card'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _cardType == "MASTERCARD"
              ? [const Color(0xFFEB001B), const Color(0xFFF79E1B)]
              : [const Color(0xFF1D3854), const Color(0xFF0F69E7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _cardType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Icon(Icons.nfc, color: Colors.white70, size: 32),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            _cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CARD HOLDER',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _cardHolder,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'EXPIRES',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _expiryDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

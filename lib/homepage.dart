import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:postestapp/detailspage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        "image1": "assets/images/momo.png",
        "image2": "assets/images/momoicon.png",
        "title": "Mobile \nPayment",
      },
      {
        "image1": "assets/images/card.png",
        "image2": "assets/images/cardicon.png",
        "title": "Card \nPayment",
        "color": "#1D3854",
      },
      {
        "image1": "",
        "image2": "assets/images/qr.png",
        "title": "Qr \nPayment",
        "color": "#1D3854",
      },
      {
        "image1": "",
        "image2": "assets/images/terminal.png",
        "title": "Terminal \nManagement",
        "color": "#1D3854",
      },
      {
        "image1": "",
        "image2": "assets/images/kiosk.png",
        "title": "Toggle \nKiosk Mode",
        "color": "#1D3854",
      },
      {
        "image1": "",
        "image2": "assets/images/history.png",
        "title": "View \nHistory",
        "bgImage": "assets/images/historyimage.png",
      },
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.png', height: 35),
            SizedBox(height: 20),
            Text('Good Morning', style: TextStyle(fontSize: 13)),
            Text(
              'What will you like to do today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Detailspage()),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: data[index]['bgImage'] != null
                              ? null
                              : data[index]['color'] != null
                              ? Color(
                                  int.parse(
                                    data[index]['color'].replaceFirst(
                                      '#',
                                      'FF',
                                    ),
                                    radix: 16,
                                  ),
                                )
                              : Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          gradient:
                              data[index]['bgImage'] == null &&
                                  data[index]['color'] == null
                              ? LinearGradient(
                                  transform: GradientRotation(45),
                                  colors: [
                                    Color(0xFF3FA3DB),
                                    Color(0xFF0F69E7),
                                  ],
                                )
                              : null,
                          image: data[index]['bgImage'] != null
                              ? DecorationImage(
                                  image: AssetImage(data[index]['bgImage']),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: (data[index]['image1'] != '')
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.end,
                                children: [
                                  if (data[index]['image1'] != '')
                                    Image.asset(
                                      data[index]['image1'],
                                      height: 25,
                                    ),
                                  Image.asset(
                                    data[index]['image2'],
                                    height: 35,
                                  ),
                                ],
                              ),
                              Text(
                                data[index]['title'],
                                style: TextStyle(
                                  color: data[index]['bgImage'] != null
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Powered by ", style: TextStyle(fontSize: 12)),
                  Image.asset("assets/images/plogo.png", height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

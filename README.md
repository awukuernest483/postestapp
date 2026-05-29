# postestapp

A Flutter POS test app built from a Figma design, using GetX for state management and routing.

## Getting Started

```bash
flutter pub get
flutter run
```

## Implementation Notes

### Figma components used

The following Figma components were exported as SVGs and dropped into `assets/icons/`:

- **Payment icons** (62 × 62 circular badges): `cardicon.svg`, `momoicon.svg`, `qr.svg`, `terminal.svg`, `kiosk.svg`, `history.svg`
- **Brand / illustration assets**: `card.svg` (overlapping Visa cards used as the Card Payment side-illustration), `momo.svg` (MTN MoMo logo used as the Mobile Payment side-illustration)
- **Spare icons** (currently unused): `Frame 6.svg` (back arrow), `Frame 7.svg` (circular shape) — kept in `assets/icons/` pending design clarification

The card background photo (`assets/images/historyimage.png`), the top app logo (`logo.png`), and the "Powered by" logo (`plogo.png`) were kept as PNGs because they're raster images, not vector components.

### Mapping Figma components → Flutter widgets

| Figma | Flutter |
|---|---|
| Home screen card grid | `MasonryGridView.builder` with a 2-column `SliverSimpleGridDelegateWithFixedCrossAxisCount` |
| Individual tile | `_OptionCard` (private widget) wrapping `GestureDetector` → `AspectRatio(1.0)` → `Container(decoration: BoxDecoration(...))` |
| Tile gradient (Mobile Payment) | `LinearGradient(transform: GradientRotation(45), colors: [Color(0xFF3FA3DB), Color(0xFF0F69E7)])` |
| Tile solid color (Card / QR / Terminal / Kiosk) | `Color(0xFF1D3854)` parsed from the data layer's `#1D3854` string |
| Tile image background (History) | `DecorationImage(image: AssetImage(...), fit: BoxFit.cover)` |
| Figma SVG icons | `SvgPicture.asset(...)` from `flutter_svg` |
| Card title typography | Urbanist 19 / `FontWeight.w900` (white on dark tiles, black on the history tile) |
| Greeting text | Hard-coded "Good Morning" exposed as `RxString` on `HomeController` for future time-of-day swap |

Routing and screens use the modular GetX layout under `lib/app/`:

```
lib/app/
  routes/        app_routes.dart, app_pages.dart
  theme/         app_theme.dart        (Material 3 + Urbanist text theme)
  modules/
    home/        bindings/ controllers/ views/
    details/     bindings/ controllers/ views/
```

`main.dart` boots a `GetMaterialApp` with `initialRoute: AppPages.initial` and `getPages: AppPages.routes`. Each module's `Binding` registers its controller via `Get.lazyPut`, so controllers are constructed only when the route is visited.

### Packages added and why

| Package | Why |
|---|---|
| `get: ^4.7.2` | State management, dependency injection, and named routing — supports the modular GetX architecture |
| `flutter_svg: ^2.0.10+1` | Renders the Figma-exported SVG icons in `assets/icons/` |
| `flutter_staggered_grid_view: ^0.7.0` | Provides `MasonryGridView` for the home grid |
| `google_fonts: ^8.0.0` | Loads the Urbanist typeface specified in the design |
| `nfc_manager: ^4.1.1` | NFC tag reading for card / contactless payment flows |
| `cupertino_icons: ^1.0.8` | Default iOS-style icons |

### Staggered grid layout

The grid uses `MasonryGridView.builder` with:

- `SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)` — two columns
- `crossAxisSpacing: 10`, `mainAxisSpacing: 10`
- `physics: NeverScrollableScrollPhysics()` because the grid is wrapped in `Expanded` inside a non-scrolling `Column` (the full screen fits on a phone, so scrolling is disabled)
- Each tile is wrapped in `AspectRatio(aspectRatio: 1.0)` so the cards are perfect squares regardless of column width

`MasonryGridView` was chosen over `GridView` so we keep the option of tiles with differing heights later without re-architecting the layout.

### NFC support

NFC is integrated through the `nfc_manager` package and the Android side is wired in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc" android:required="false" />
```

`android:required="false"` keeps the app installable on devices without NFC hardware — the feature will simply degrade gracefully. iOS NFC entitlements (Core NFC capability + `NFCReaderUsageDescription` in `Info.plist`) are **not** yet configured; that needs to happen when the iOS NFC flow is wired up.

### Assumptions made

- The greeting "Good Morning" is hard-coded; a time-of-day-aware greeting can swap in trivially via `HomeController.greeting`.
- The View History card uses `historyimage.png` as a full background image with black title text; the rest of the cards use solid colors / a gradient with white text.
- The details page is a placeholder — it reads the tapped `PaymentOption` from `Get.arguments` and renders the icon + title. The real per-tile workflow (start NFC scan, present QR, etc.) is intentionally out of scope.
- Tile palette: gradient `#3FA3DB → #0F69E7` for Mobile Payment, solid `#1D3854` for the rest. Inferred from the Figma artboard.

### Assets that had to be approximated

- The original Figma file was not connected — only individual SVG exports were provided.
- `Frame 6.svg` (back arrow) and `Frame 7.svg` (circular outline) had no obvious matching slot in the home grid; left in `assets/icons/` for future use.
- Before the user's real Figma exports arrived, the project briefly shipped with placeholder SVGs I drew inline. Those have been fully replaced.

### APK output path

Release APK is built to:

```
build/app/outputs/flutter-apk/app-release.apk
```

A copy of the latest release build is also kept at the project root as `postestapp.apk` for convenience.

Build command:

```bash
flutter build apk --release
```

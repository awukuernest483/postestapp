# postestapp

A Flutter POS test app built from a Figma design. The current scope is the homepage only.

## Getting Started

```bash
flutter pub get
flutter run
```

## Implementation Notes

### Scope

Per the project constraints, the homepage is the only screen built. No backend, no external APIs, no invented UI elements.

### Figma components used

The following Figma components were exported as SVGs and dropped into `assets/icons/`:

- **Payment icons** (62 × 62 circular badges): `cardicon.svg`, `momoicon.svg`, `qr.svg`, `terminal.svg`, `kiosk.svg`, `history.svg`
- **Brand / illustration assets**: `card.svg` (overlapping Visa cards used as the Card Payment side-illustration), `momo.svg` (MTN MoMo logo used as the Mobile Payment side-illustration)
- **Out-of-scope but kept**: `Frame 6.svg` (back arrow) and `Frame 7.svg` (circle) — exported components that belong to other screens which aren't built in this scope. Kept in `assets/icons/` so they aren't lost when those screens are added later.

`logo.png`, `plogo.png`, and `historyimage.png` were kept as PNGs because they're raster brand / illustration assets, not vector components.

### Mapping Figma components → Flutter widgets

| Figma | Flutter |
|---|---|
| Home screen card grid | `MasonryGridView.builder` with a 2-column `SliverSimpleGridDelegateWithFixedCrossAxisCount` |
| Individual tile | `OptionCard` (its own file) → `AspectRatio(1.0)` → `DecoratedBox(BoxDecoration(...))` |
| Tile gradient (Mobile Payment) | `AppColors.mobilePaymentGradient` — `LinearGradient(transform: GradientRotation(45), colors: [#3FA3DB, #0F69E7])` |
| Tile solid color (Card / QR / Terminal / Kiosk) | `AppColors.tileSurface` = `Color(0xFF1D3854)` |
| Tile image background (History) | `DecorationImage(image: AssetImage(AppAssets.historyBackground), fit: BoxFit.cover)` |
| Figma SVG icons | `SvgPicture.asset(...)` from `flutter_svg` |
| Card title typography | Urbanist 19 / `FontWeight.w900` (white on dark tiles, black on the History tile) |
| Greeting | `HomeController.greeting` — derives "Good Morning / Afternoon / Evening" from the local hour |

### Project structure

```
lib/
├── main.dart
└── app/
    ├── routes/                      app_routes.dart, app_pages.dart
    ├── theme/                       app_theme.dart, app_colors.dart, app_text_styles.dart
    ├── core/constants/              app_assets.dart
    ├── data/models/                 payment_option.dart
    └── modules/home/
        ├── bindings/                home_binding.dart
        ├── controllers/             home_controller.dart
        ├── views/                   home_view.dart
        └── widgets/                 option_card.dart
```

`main.dart` boots a `GetMaterialApp` with `initialRoute: AppPages.initial` and `getPages: AppPages.routes`. The home module's `Binding` registers `HomeController` via `Get.lazyPut`, so it's constructed only when the route is visited.

### Packages used and why

| Package | Why |
|---|---|
| `get` | State management, dependency injection, and named routing — supports the modular GetX architecture |
| `flutter_svg` | Renders the Figma-exported SVG icons in `assets/icons/` |
| `flutter_staggered_grid_view` | Provides `MasonryGridView` for the home grid |
| `nfc_manager` | NFC tag reading for the card / contactless payment flow declared in the design |
| `cupertino_icons` | Default iOS-style icons |

`google_fonts` was intentionally **not** used: it fetches typography from `fonts.gstatic.com` at runtime, which is an external API call. Urbanist is bundled directly under `assets/fonts/` and registered as a native Flutter font family.

### Staggered grid layout

The grid uses `MasonryGridView.builder` with:

- `SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)` — two columns
- `crossAxisSpacing: 10`, `mainAxisSpacing: 10`
- `physics: NeverScrollableScrollPhysics()` because the grid lives inside an `Expanded` in a non-scrolling `Column`
- Each tile is wrapped in `AspectRatio(aspectRatio: 1.0)` so the cards are perfect squares regardless of column width

`MasonryGridView` keeps the door open for tiles with differing heights without re-architecting the layout.

### NFC support

NFC is integrated through the `nfc_manager` package and the Android side is wired in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc" android:required="false" />
```

`android:required="false"` keeps the app installable on devices without NFC hardware. iOS NFC entitlements (Core NFC capability + `NFCReaderUsageDescription`) will need to be added when the iOS NFC flow is wired up — out of scope here since only the homepage is built.

### Typography (Urbanist)

Urbanist is bundled directly:

- TTFs live under `assets/fonts/` (Regular 400, Medium 500, SemiBold 600, Bold 700, ExtraBold 800, Black 900)
- Registered in `pubspec.yaml` under `flutter.fonts` with the family name `Urbanist`
- `AppTheme.light` sets `fontFamily: 'Urbanist'` so every Material widget inherits it
- `AppTextStyles` exposes `const TextStyle(fontFamily: 'Urbanist', ...)` for each text role used on the homepage

No network calls, no third-party font fetcher.

### Assumptions

- The greeting is derived from the local hour (Morning / Afternoon / Evening). The Figma copy shows "Good Morning"; that text appears between roughly 5 AM and 12 PM.
- Tile palette inferred from the Figma artboard: gradient `#3FA3DB → #0F69E7` for Mobile Payment, solid `#1D3854` for the rest of the dark tiles, and a full-bleed background image on the View History tile.
- No tap behavior was wired to the tiles. The constraints forbid building any non-homepage screen, so navigation has nowhere to land.

### Assets that had to be approximated

- The original Figma file was not connected — only individual SVG exports were provided.
- `Frame 6.svg` (back arrow) and `Frame 7.svg` (circle) are kept under `assets/icons/` as out-of-scope exports.

### APK output path

Release APK is built to:

```
build/app/outputs/flutter-apk/app-release.apk
```

A copy of the latest release build is kept at the project root as `postestapp.apk`.

Build command:

```bash
flutter build apk --release
```

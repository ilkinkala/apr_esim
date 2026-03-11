# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this repository.

## Project Overview

APR eSIM (xSim) is a **Flutter mobile application** for purchasing and managing eSIM data plans. It provides mobile data connectivity across 190+ countries without physical SIM swapping. Built by APR-KS, the app targets both iOS and Android platforms.

**Status:** Early development — core infrastructure, splash screen, onboarding flow, and design system are complete. Navigation routing, backend integration, and feature screens are not yet implemented.

## Build & Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Run on a specific device
flutter run -d <device_id>

# Build for iOS
flutter build ios

# Build for Android
flutter build apk

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Static analysis (lint checks)
flutter analyze

# Format all Dart code
dart format .

# List available devices
flutter devices
```

## Architecture

The project uses a **feature-first architecture** with clean separation of concerns and Riverpod for state management.

```
lib/
├── main.dart                          # Entry point — ProviderScope + ScreenUtilInit
├── core/
│   └── constants/
│       ├── app_colors.dart            # Brand colors (primary: Cyprus Green #004643)
│       ├── app_text_styles.dart       # Typography hierarchy
│       └── app_constants.dart         # API config, storage keys, validation rules
├── features/
│   └── authentication/
│       └── presentation/
│           └── screens/
│               ├── splash_screen.dart     # Animated splash (1500ms duration)
│               └── onboarding_screen.dart # 3-page carousel with wave/card animations
└── shared/
    └── theme/
        └── app_theme.dart             # Material 3 light & dark themes
```

### Feature Directory Convention

Each feature should follow this structure:

```
features/<feature_name>/
├── data/           # Repositories, data sources, models
├── domain/         # Business logic, entities, use cases
└── presentation/
    ├── screens/    # Full-screen widgets
    ├── widgets/    # Feature-specific reusable widgets
    └── providers/  # Riverpod providers for this feature
```

### Key Architectural Decisions

- **State Management:** `flutter_riverpod` ^3.2.0 — app wrapped in `ProviderScope`
- **Navigation:** `go_router` ^17.0.1 (added as dependency, not yet wired up)
- **Networking:** `dio` ^5.9.0 for HTTP (API base URL is a placeholder)
- **Responsive UI:** `flutter_screenutil` ^5.9.3, design size = iPhone 14 Pro (390 x 844)
- **Secure Storage:** `flutter_secure_storage` for tokens/credentials
- **General Storage:** `shared_preferences` for user preferences
- **Orientation:** Portrait-only (locked in `main.dart`)
- **Theme Mode:** Light mode default, dark theme defined but not toggled yet

## Code Conventions

### Naming

- **Classes/Enums:** PascalCase (`APReSIMApp`, `OnboardingData`, `PageType`)
- **Private members:** Leading underscore (`_SplashScreenState`, `_fadeAnimation`)
- **Variables/Methods:** camelCase (`navigateToHome`, `currentPage`)
- **Constants:** PascalCase static members on classes (`AppColors.primary`, `AppConstants.appName`)
- **Files:** snake_case (`app_colors.dart`, `splash_screen.dart`)

### Imports

- Package imports first (`package:flutter/...`, `package:flutter_riverpod/...`)
- Then local/relative imports
- Use relative imports for files within the same package

### Widget Patterns

- `StatefulWidget` with `SingleTickerProviderStateMixin` for animated screens
- Custom `CustomPainter` classes for decorative backgrounds (waves, cards)
- All sizing uses flutter_screenutil extensions: `.w` (width), `.h` (height), `.sp` (font size), `.r` (border radius)
- Colors from `AppColors`, typography from `AppTextStyles` — never use raw color/style literals
- Section dividers with decorative comments: `// ─────────────────────────────────`

### Constants

- All colors centralized in `AppColors` (non-instantiable class with private constructor)
- All text styles in `AppTextStyles`
- App configuration, storage keys, and validation rules in `AppConstants`
- Same private-constructor pattern (`ClassName._()`) for all constant classes

## Design System

- **Primary Color:** Cyprus Green `#004643`
- **Background:** Cream `#F0EDE5`
- **Text Primary:** Charcoal `#1A1A1A`
- **Theme:** Material 3 with custom `ColorScheme`
- **Typography:** System default font with defined hierarchy (headlineLarge through bodySmall)
- **Design Reference Size:** 390 x 844 (iPhone 14 Pro)

## Dependencies

| Package | Purpose |
|---|---|
| `flutter_riverpod` | State management |
| `dio` | HTTP networking |
| `flutter_secure_storage` | Encrypted credential storage |
| `shared_preferences` | Key-value local storage |
| `flutter_screenutil` | Responsive sizing |
| `go_router` | Declarative navigation |
| `intl` | Internationalization |
| `qr_flutter` | QR code rendering |

**Dev Dependencies:** `flutter_test` (testing), `flutter_lints` ^6.0.0 (linting)

## Linting

- Uses `package:flutter_lints/flutter.yaml` (standard Flutter lint rules)
- Config in `analysis_options.yaml`
- Run `flutter analyze` before committing to catch issues
- Run `dart format .` to auto-format

## Testing

- Test files go in `test/` directory
- Framework: `flutter_test`
- Current coverage is minimal (placeholder `widget_test.dart` only)
- Widget tests use `testWidgets` with `WidgetTester`

## Assets

- Onboarding images: `assets/images/onboarding/`
- Asset directories must be registered in `pubspec.yaml` under `flutter.assets`

## Important Notes

- `pubspec.yaml` has `publish_to: 'none'` — this is a private app, not a pub package
- Dart SDK constraint: `^3.10.7`
- API configuration in `AppConstants` uses placeholder values — do not commit real API keys
- The app entry point class is `APReSIMApp` (note capitalization)

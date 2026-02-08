# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

APR eSIM is a Flutter mobile application for purchasing and managing eSIM data plans. The app targets iOS and Android, providing users with mobile data connectivity in 190+ countries.

## Build & Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Run on specific device
flutter run -d <device_id>

# Build for iOS
flutter build ios

# Build for Android
flutter build apk

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Analyze code for issues
flutter analyze

# Format code
dart format .
```

## Architecture

The project follows a **feature-first architecture** with clean separation of concerns:

```
lib/
├── main.dart                 # App entry point with ProviderScope wrapper
├── core/
│   └── constants/           # App-wide constants (colors, text styles, config)
├── features/
│   └── <feature>/
│       └── presentation/
│           └── screens/     # UI screens for each feature
└── shared/
    └── theme/               # Material 3 theme configuration
```

### Key Architectural Decisions

- **State Management**: Riverpod (`flutter_riverpod`) - app is wrapped in `ProviderScope`
- **Navigation**: go_router (configured but not yet implemented)
- **Networking**: Dio for HTTP requests
- **Responsive UI**: flutter_screenutil with iPhone 14 Pro design size (390x844)
- **Storage**: flutter_secure_storage for sensitive data, shared_preferences for general preferences

### Design System

- **Colors**: Defined in `lib/core/constants/app_colors.dart` - Primary brand color is Cyprus Green (#004643)
- **Typography**: Defined in `lib/core/constants/app_text_styles.dart`
- **Theme**: Material 3 theme in `lib/shared/theme/app_theme.dart`

### Responsive Sizing

Use flutter_screenutil extensions for all sizing:
- `.w` for width
- `.h` for height
- `.sp` for font sizes
- `.r` for border radius

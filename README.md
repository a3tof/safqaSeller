# Safqa Seller

`Safqa Seller` is the Flutter seller application for the Safqa auction platform. It includes seller onboarding, authentication, profile management, auction creation and editing, history, notifications, chat, wallet flows, and subscription upgrades.

## Tech Stack

- Flutter with Material UI
- `flutter_bloc` / `bloc` for Cubit-based state management
- `get_it` for dependency injection
- `dio` for API communication
- `shared_preferences` for local persistence
- `intl` + generated localization files for Arabic and English
- `flutter_screenutil` for responsive sizing
- `workmanager` and local notification services for background/foreground notification handling

## Project Structure

The codebase follows a feature-first structure with MVVM naming:

```text
lib/
├── core/
│   ├── config/
│   ├── helper_functions/
│   ├── network/
│   ├── service_locator.dart
│   ├── storage/
│   ├── utils/
│   └── widgets/
└── features/<feature>/
    ├── view/
    │   └── widgets/
    ├── view_model/
    └── model/
        ├── models/
        └── repositories/
```

Key conventions:

- Views live under `view/`
- Cubits and states live under `view_model/`
- API and persistence logic stay inside repositories
- Shared app infrastructure stays in `lib/core/`
- Routing is centralized in `lib/core/helper_functions/on_generate_routes.dart`

## Main Features

- Authentication and account recovery
- Seller profile and account editing
- Complete-profile onboarding flow
- Auction creation, editing, and details
- History and seller dashboard flows
- Notifications with background sync
- Chat conversations and threads
- Wallet, cards, deposits, withdrawals, and subscriptions
- Arabic and English localization

## Getting Started

### Prerequisites

- Flutter SDK compatible with Dart `^3.10.3`
- A working Android/iOS/desktop/web Flutter setup, depending on your target platform

### Install Dependencies

```bash
flutter pub get
```

### Configure the App

Review `lib/core/config/app_config.dart` before running the app. It contains:

- API base URL
- API key
- Google Sign-In client ID
- Facebook app configuration

Keep all backend and OAuth configuration in `AppConfig`. New code should not introduce duplicate config constants elsewhere.

### Run the App

```bash
flutter run
```

## Development Notes

### State Management

- The app uses `Cubit`, not event-based `Bloc`
- Repositories are registered with `GetIt` as lazy singletons
- Screen-scoped Cubits are registered as factories
- App-wide state such as `AuthViewModel` and `ProfileViewModel` is restored on startup

### Routing

- Every screen exposes a `routeName`
- All named routes are handled in `lib/core/helper_functions/on_generate_routes.dart`
- Route arguments should use typed argument classes when a screen needs input data

### Localization

- Supported locales are English (`en`) and Arabic (`ar`)
- Add new strings to the ARB files under `lib/l10n/`
- Use `S.of(context)` in widgets instead of hardcoded UI strings
- Avoid manually editing generated files under `lib/generated/`

## Useful Commands

```bash
flutter analyze
flutter test
dart format lib test
```

## Repository Notes

- `.cursor/` contains local Cursor rules and settings guidance
- `.dart_tool/`, build outputs, and other generated files are ignored

## License

This repository is private and intended for internal Safqa development.

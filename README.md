# LiveToura — Flutter & Dart Basics (Sprint 2)

A starter cross-platform Flutter app. This sprint initializes the project, sets up a clean folder structure, and replaces the default counter with a simple Welcome screen demonstrating widgets, state, and Dart syntax.

## Demo

Add a screenshot of the running app here:

![App Screenshot](assets/demo/screenshot.png)

## Project Structure

```
lib/
├── main.dart          # Entry point of the app
├── screens/           # Individual UI screens
├── widgets/           # Reusable UI components
├── models/            # Data models (optional for now)
└── services/          # API/Firebase services (future use)
```

### Directory purposes
- lib/main.dart: App bootstrap, theme, and initial route.
- lib/screens/: Each file defines a single, focused screen widget.
- lib/widgets/: Small, reusable UI pieces shared by multiple screens.
- lib/models/: Plain Dart objects for data representation and serialization.
- lib/services/: Abstractions over external integrations (Firebase, HTTP APIs).

### Modular design benefits
- Separation of concerns: UI vs. services vs. data.
- Reuse: Widgets composed across screens.
- Scalability: New features drop into clearly defined folders.
- Testability: Smaller, focused units are easier to test.

### Naming conventions
- Files: lowercase_with_underscores.dart (e.g., welcome_screen.dart)
- Classes/Widgets: UpperCamelCase (e.g., WelcomeScreen)
- Private members: leading underscore (e.g., _isToggled)
- Constants: lowerCamelCase or ALL_CAPS for compile-time consts

## Setup Instructions

1) Install Flutter SDK and an editor (VS Code or Android Studio). Add Flutter to PATH.
2) Verify your environment:

```
flutter doctor
```

3) If creating from scratch:

```
flutter create live_toura
```

4) Get packages and run:

```
flutter pub get
flutter run -d <deviceId>
```

5) Take a screenshot on your emulator/device and save to assets/demo/screenshot.png, then refresh this README if you used a different path.

## Reflection
- What I learned about Dart & Flutter widgets and state:
- How this folder structure will help me scale complex UIs later:
- Design/naming decisions made in this project:

## Submission
- Commit message:
  - feat: initialized Flutter project and basic UI setup
- PR Title:
  - [Sprint-2] Flutter & Dart Basics – TeamName
- PR Description should include: summary, screenshot, reflection, and naming/design decisions.

## Video
Record a 1–2 minute demo showing: the app running, folder structure in the IDE, a quick walk-through of widget composition, and a state change interaction. Upload unlisted and place the link in the PR.

## Setup Verification

### Steps Followed
1.  **Installed Flutter SDK**: Downloaded and configured Flutter SDK.
2.  **Configured Android Studio/VS Code**: Installed necessary Flutter and Dart plugins.
3.  **Emulator Setup**: Configured Android Emulator (Pixel 6).
4.  **Created Project**: Ran `flutter create first_flutter_app`.
5.  **Verified Installation**: Ran `flutter doctor`.

### Screenshots
*(Place your screenshots here)*
-   **Flutter Doctor**: `flutter_doctor_output.png`
-   **Running App**: `emulator_screen.png`

### Reflection
Setting up the environment was straightforward. The main challenge was ensuring the Android SDK path was correctly set in the environment variables. This setup is crucial as it allows for real-time testing and debugging on emulated devices, which is essential for mobile development. Ready to build amazing apps!

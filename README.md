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

**[ 📂 Click here for a detailed breakdown of the Project Structure >](PROJECT_STRUCTURE.md)**

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
1.  **Installed Flutter SDK**: Verified Flutter SDK v3.29.0 is installed.
2.  **Environment Check**: Ran `flutter doctor` to diagnose setup issues.
    -   **Web**: Connected and ready (Chrome/Edge).
    -   **Windows**: Visual Studio C++ components missing.
    -   **Android**: Android SDK not found.
3.  **App Verification**: Validated the existing **LiveToura** project by successfully building for Web (`flutter build web`).
    -   *Note: Removed redundant `first_flutter_app` folder as the main project repository is already initialized.*
4.  **Next Steps**: 
    -   Install Android Studio and SDK for mobile development.
    -   Install "Desktop development with C++" workload in Visual Studio for Windows support.

### Verification Output
**Flutter Doctor Output:**
```
[√] Flutter (Channel stable, 3.29.0, on Microsoft Windows [Version 10.0.26200.7840], locale en-US)
[X] Android toolchain - develop for Android devices
    X Unable to locate Android SDK.
[X] Visual Studio - develop Windows apps
    X Visual Studio is missing necessary components.
[√] Chrome - develop for the web
[√] Connected device (3 available)
```

### Reflection
The Flutter SDK installation was successful, allowing for web development immediately. However, full mobile and desktop support requires additional platform-specific tools (Android Studio, Visual Studio C++ workload). Prioritizing web verification allowed us to confirm the Flutter installation itself is healthy while pending the larger downloads for Android/Windows.

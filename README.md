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

## Stateless vs Stateful Widgets Demo

### Project Title
Stateless vs Stateful Widgets Interactive Demo App

### Explanation
- **StatelessWidget**: A widget that has no internal state. It displays static content that doesn't change after being built. Use it for UI components that remain constant, such as headers, labels, and icons. This widget will not rebuild unless its parent widget triggers an update.
- **StatefulWidget**: A widget that maintains internal state that changes during runtime. It rebuilds its UI dynamically whenever the state is updated using `setState()`.

### Code Snippets

**Stateless Widget Example:**
```dart
class StatelessHeader extends StatelessWidget {
  final String title;
  final String description;

  const StatelessHeader({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(description),
      ],
    );
  }
}
```

**Stateful Widget Example:**
```dart
class InteractiveCounterWidget extends StatefulWidget {
  const InteractiveCounterWidget({super.key});

  @override
  State<InteractiveCounterWidget> createState() => _InteractiveCounterWidgetState();
}

class _InteractiveCounterWidgetState extends State<InteractiveCounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_counter'),
        ElevatedButton(onPressed: _increment, child: const Text('Increase')),
      ],
    );
  }
}
```

### Screenshots Location
- Initial UI State: `assets/demo/stateless_stateful_initial.png`
- Updated UI State (after interaction): `assets/demo/stateless_stateful_updated.png`

*(Please replace placeholders with actual screenshot files)*

### Extended Reflection

- **When should you prefer Stateless widgets?**
  When your UI part depends only on the initialization configuration and doesn't change dynamically based on user interaction or internal variables. They are lighter and faster.

- **When are Stateful widgets necessary?**
  When your UI needs to react to user inputs (like button clicks, form fields), animations, or data streams that change over time and require the UI to update to reflect the new state.

- **How does Flutter rebuild only the widgets that change?**
  Flutter uses an efficient diffing algorithm on the Widget tree and Element tree. When `setState` is called, it marks that specific Element as "dirty". During the next frame, Flutter rebuilds only that dirty element and its descendants, rather than rebuilding the entire screen.

- **How do Stateful widgets make the UI dynamic?**
  By maintaining a separated `State` object that outlives the widget itself. When data inside the `State` object is modified inside a `setState()` call, it triggers a UI rebuild of the widget's subtree to display the updated data.

- **Why is understanding widget types essential for performance and clarity?**
  Overusing Stateful widgets can lead to unnecessary rebuilds, which degrades performance. Keeping state scoped to only the widgets that need it makes the code easier to reason about, maintain, and optimize.

## Hot Reload, Debug Console, and DevTools Demo

### Project Title
LiveToura - Hot Reload & DevTools Demonstration

### Step-by-Step Explanation
1. **Hot Reload**: Modified the `responsive_home.dart` file (e.g., changed the background color or updated a text widget). Pressed `r` in the terminal (or clicked the Hot Reload button in the IDE) to instantly see the updated UI on the running app without losing the current state.
2. **Debug Console**: Added a `debugPrint()` statement inside the `build` method or interaction callbacks to trace the widget's render lifecycle. Ran the app and observed the console output in VS Code/Android Studio to ensure variables and events were logging properly.
3. **Flutter DevTools**: Launched DevTools running `flutter pub global run devtools` from the terminal (or via IDE). Used the **Widget Inspector** to visualize the Flutter widget tree and interactively select UI elements. Checked the **Performance** tab to ensure the UI renders smoothly.

### Screenshots Location
- Hot Reload in action: `assets/demo/hot_reload_demo.png`
- Debug Console logs: `assets/demo/debug_console_logs.png`
- DevTools window: `assets/demo/devtools_inspector.png`

*(Please replace placeholders with actual screenshot files)*

### Reflection

- **How does Hot Reload improve development speed?**
  Hot Reload injects updated source code files directly into the running Dart Virtual Machine, allowing developers to see UI changes almost instantaneously. It eliminates the need to compile and restart the app from scratch, making UI iteration significantly faster while preserving the app's current state.

- **Why are debugging and profiling essential for app optimization?**
  Debugging helps identify logical flaws and runtime errors that could crash the app or lead to incorrect behavior. Profiling (via DevTools) allows us to detect performance bottlenecks like slow frame rendering, memory leaks, and excessive widget rebuilds, ensuring the app runs smoothly and efficiently.

- **How can these tools be integrated into a team workflow?**
  Team members can use the Debug Console to leave informative log trails for complex logic, making it easier for others to understand the flow. DevTools can be used during code reviews to verify UI performance and spot memory leaks before merging PRs. Hot Reload allows pair programming sessions to flow much quicker as both developers can see changes live.

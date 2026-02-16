# 🏗️ Flutter Project Structure & Architecture

A comprehensive guide to the anatomy of a scalable Flutter application, detailing the purpose of key directories and files.

---

## 📂 Directory Overview

### 1. 🎯 **`lib/` (The Core)**
The heart of your Flutter application. This directory contains 99% of the code you will write.
- **`main.dart`**: The entry point of the application. It initializes the app and sets up themes and routes.
- **Sub-directories (Best Practice)**:
  - `screens/`: Individual pages/views of the app (e.g., `LoginScreen`, `ResponsiveHomeScreen`).
  - `widgets/`: Reusable UI components (buttons, cards, etc.).
  - `models/`: Data classes defining the structure of your data.
  - `services/`: Logic for API calls, Database, and Authentication (`AuthService`, `FirestoreService`).
  - `utils/`: Helper functions, constants, and themes.

### 2. 🤖 **`android/`**
Native Android project files.
- Contains the Gradle build scripts (`build.gradle`) and the Android Manifest (`AndroidManifest.xml`).
- Used for configuring Android-specific permissions, icons, and dependencies (like Firebase).
- **Key File**: `google-services.json` (Firebase Configuration).

### 3. 🍎 **`ios/`**
Native iOS project files.
- Contains the Xcode project workspace.
- **`Runner/Info.plist`**: The critical file for configuring iOS permissions (Camera, Location, etc.) and app settings.
- **Key File**: `GoogleService-Info.plist` (Firebase Configuration).

### 4. 🌐 **`web/`**
Web-specific configuration files.
- **`index.html`**: The main HTML entry point for the web app.
- **`manifest.json`**: Configuration for PWA (Progressive Web App) behavior.

### 5. 🎨 **`assets/`**
A manually created directory for static resources.
- **Images**: `.png`, `.jpg`, `.svg`
- **Fonts**: Custom font files (e.g., `.ttf`)
- **Data**: Static JSON or config files.
*Note: All assets must be registered in `pubspec.yaml`.*

### 6. 🧪 **`test/`**
Home for automated tests.
- **Unit Tests**: Verify individual functions or classes.
- **Widget Tests**: Verify UI component behavior.
- **Integration Tests**: Verify complete app flows.

---

## ⚙️ Configuration Files

| File | Purpose |
| :--- | :--- |
| **`pubspec.yaml`** | **The Brain.** Manages dependencies (packages like `firebase_auth`, `google_sign_in`), assets, fonts, and app versioning. |
| **`analysis_options.yaml`** | Configures linting rules to enforce code style and catch errors. |
| **`.gitignore`** | Specifies files that Git should ignore (e.g., build artifacts, API keys). |
| **`README.md`** | The project's landing page. Contains setup instructions and documentation. |
| **`firebase_options.dart`** | Auto-generated configuration file connecting your app to Firebase projects. |

---

## 📐 LiveToura Architecture Pattern

We follow a feature-first or clean architecture approach:

```text
lib/
├── main.dart            # App entry point
├── firebase_options.dart # Firebase config
├── screens/             # UI Screens
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── responsive_home.dart
│   └── welcome_screen.dart
├── services/            # Business Logic
│   ├── auth_service.dart
│   └── firestore_service.dart
└── widgets/             # Shared Widgets
```

---

## 💡 Why This Matters

Understanding this structure is critical for:
1.  **Teamwork**: Everyone knows exactly where to find and place code.
2.  **Scalability**: A well-organized codebase can grow without becoming a "spaghetti code" mess.
3.  **Maintenance**: Separating logic (Services) from UI (Screens) makes updates and bug fixes safer and faster.

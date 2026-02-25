# Tournament Tracker - Live Community Sports Scoring App

## Project Description

**Tournament Tracker** is a mobile-first Flutter application integrated with Firebase that allows organizers to update match scores in real-time while spectators and players can instantly view match results, player stats, and tournament standings. Community sports tournaments often struggle to provide live score updates and player statistics. Tournament Tracker solves this by providing instant transparency and engagement through a seamless mobile experience.

## Tech Stack

- **Mobile Frontend:** Flutter (Dart)
- **Backend Platform:** Firebase
  - Firebase Authentication (secure login and user management)
  - Cloud Firestore (real-time database storage and synchronization)
- **Version Control & CI/CD:** GitHub

---

## Concept-1: Exploring Flutter & Dart Fundamentals for Cross-Platform UI Development

### Objective
To understand Flutter's architecture, widget-based UI system, and Dart language fundamentals for creating interactive, reactive, and visually consistent mobile interfaces.

---

### 1. Understanding Flutter's Architecture

#### Core Layers of Flutter

| Layer | Description |
|-------|-------------|
| **Framework Layer** | Written in Dart. Includes Material/Cupertino widgets, rendering, and animation libraries. |
| **Engine Layer** | Built in C++. Handles rendering (Skia), text layout, and platform channels. |
| **Embedder Layer** | Integrates Flutter with platform-specific APIs on Android, iOS, web, or desktop. |

#### Key Architectural Insight
Flutter **doesn't use native UI components** — it renders everything itself using the Skia engine, ensuring pixel-perfect design consistency across devices. This is what makes Flutter truly cross-platform: the same code produces identical visuals on Android, iOS, web, and desktop.

**Why This Matters:**
- **Consistency:** No visual discrepancies between platforms
- **Performance:** Direct control over rendering pipeline
- **Customization:** Unlimited UI possibilities without platform constraints

---

### 2. Exploring the Widget Tree

#### Key Concept: Everything is a Widget
In Flutter, **widgets are the building blocks of UIs**. A widget describes what a piece of the UI should look like. The widget tree is the hierarchical structure of these widgets, starting from the root `MaterialApp` down to individual UI elements.

#### Two Main Types of Widgets

**StatelessWidget** → For static UIs that never change
- No internal state
- Efficient and lightweight
- Examples: labels, icons, static text, images
- Renders once based on constructor parameters

**StatefulWidget** → For dynamic UIs that update with interaction or data
- Maintains mutable state
- Calls `setState()` to trigger re-renders
- Examples: counters, forms, lists, animations
- Separates into a Widget class and a State class

#### Simple Flutter UI Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hello Flutter')),
        body: Center(child: Text('Welcome to Flutter!')),
      ),
    );
  }
}
```

**How to Try It:**
1. Create a new Flutter project: `flutter create hello_flutter`
2. Replace the main.dart content with the code above
3. Run: `flutter run`
4. Change the Text widget's content and save to observe **Hot Reload** in action

---

### 3. Learning Dart Language Essentials

Dart is a modern, **object-oriented, strongly-typed language** optimized for UI development. Here are the core concepts you'll use in LiveToura:

#### Core Dart Concepts

| Concept | Description | Example Use in LiveToura |
|---------|-------------|--------------------------|
| **Classes & Objects** | Everything in Dart is an object; OOP principles apply | Model Tournament, Match, Player classes |
| **Async/Await** | Handles asynchronous operations | Fetching tournament data from Firestore |
| **Null Safety** | Prevents null reference errors at compile time | Safe data handling from Firebase |
| **Type Inference** | Declare variables without explicit types | `var` keyword for flexible typing |
| **String Interpolation** | Embed expressions in strings | `'Count: $count'` |

#### Dart Syntax Example: Student Class

```dart
class Student {
  String name;
  int age;

  // Constructor with named parameters
  Student({required this.name, required this.age});

  void introduce() {
    print('Hi, I\'m $name and I\'m $age years old.');
  }
}

void main() {
  var s1 = Student(name: 'Aanya', age: 20);
  s1.introduce(); // Output: Hi, I'm Aanya and I'm 20 years old.
}
```

**For LiveToura:** You'll use similar class structures to model Tournament, Player, and Match data.

---

### 4. StatelessWidget vs StatefulWidget - Deep Dive

#### StatelessWidget
- **Immutable:** Cannot change after creation
- **Efficient:** No state management overhead
- **Use When:** UI doesn't respond to user input or external data changes

```dart
class WelcomeCard extends StatelessWidget {
  final String title;
  
  WelcomeCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(child: Text(title));
  }
}
```

#### StatefulWidget
- **Mutable:** Maintains state that can change
- **Reactive:** Re-renders when `setState()` is called
- **Use When:** UI needs to respond to interaction or real-time data (like LiveToura)

**Structure:**
1. A `StatefulWidget` subclass (immutable)
2. A `State<WidgetName>` subclass (holds mutable state)

```dart
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName = "Guest";
  
  void updateName(String newName) {
    setState(() {
      userName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Welcome, $userName');
  }
}
```

#### Why This Separation Matters
- Widget subclass is immutable (efficient)
- State subclass holds mutable data
- This design pattern ensures performance optimization

---

### 5. Building and Explaining a Reactive UI: Counter App

The Counter App demonstrates Flutter's reactive pattern in action. When you press the button, `setState()` notifies Flutter that the state changed, and the framework efficiently re-renders only the affected widgets.

#### Complete Counter App Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stateful Widget Demo'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have clicked the button this many times:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '$count',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: increment,
          child: Icon(Icons.add),
          tooltip: 'Increment',
        ),
      ),
    );
  }
}
```

#### What's Happening Here: The Reactive Cycle

1. **User Action:** Taps the FloatingActionButton
2. **Event Handler:** `increment()` is triggered
3. **State Update:** `setState(() { count++; })`
4. **Notification:** Flutter knows state changed
5. **Differential Rendering:** Only the Text widget showing count is rebuilt
6. **UI Update:** Display shows new count value instantly

This is the **reactive rendering model** — Flutter doesn't manually change UI; it rebuilds widgets efficiently when state changes.

---

### 6. Why Dart is Ideal for Flutter's Design Goals

Dart was created by Google specifically for building UIs. Here's why it's perfect for Flutter:

| Feature | Benefit for Flutter |
|---------|-------------------|
| **Strong Typing** | Catch errors at compile-time; enables better tooling |
| **Null Safety** | Prevents null reference errors; safer code |
| **JIT & AOT Compilation** | Fast development (JIT) + optimized production builds (AOT) |
| **Garbage Collection** | Automatic memory management; simpler developer experience |
| **Hot Reload** | Edit code and see changes instantly without restart |
| **Async/Await** | Clean syntax for Firebase operations and network calls |
| **Mixins & Extensions** | Code reuse and abstraction without complex inheritance |

**For LiveToura:** Dart's async/await makes handling Firestore updates seamless; null safety ensures tournament data is handled safely.

---

### 7. How Flutter Uses the Widget Tree for Reactive UIs

#### The Widget Tree Concept

Every Flutter app is a tree of widgets:

```
MaterialApp
  ├─ Scaffold
  │   ├─ AppBar
  │   ├─ Body (Center)
  │   │   └─ Text
  │   └─ FloatingActionButton
```

#### Rendering Process

1. **Build Phase:** Widget tree is created/updated
2. **Layout Phase:** Each widget calculates its size and position
3. **Paint Phase:** Widgets are drawn to the screen
4. **Composite Phase:** Layers are combined for display

#### Efficient Re-rendering

When `setState()` is called:
- Flutter doesn't rebuild the entire tree
- It identifies changed widgets using the **Element tree**
- Only the subtree with changes is rebuilt
- This makes even complex UIs performant

---

### 8. Key Takeaways: Flutter's Advantages for Cross-Platform Development

| Aspect | Advantage |
|--------|-----------|
| **Single Codebase** | Write once, run on Android, iOS, web, desktop |
| **Pixel-Perfect UI** | Skia engine ensures identical appearance everywhere |
| **Hot Reload** | Iterate faster with instant feedback |
| **Reactive Model** | Declarative syntax is easier to reason about |
| **Performance** | Direct rendering; no JavaScript bridge overhead |
| **Rich Ecosystem** | Pub.dev has 50,000+ packages for Firebase, UI, etc. |

**For LiveToura:** Flutter enables you to deliver the same real-time tournament experience to Android and iOS users with a single codebase, dramatically reducing development time and maintenance burden.

---

## Demo App: Counter App Implementation Notes

### Setup Instructions

1. **Create Flutter Project:**
   ```bash
   flutter create counter_app
   cd counter_app
   ```

2. **Replace `lib/main.dart`** with the Counter App code above

3. **Run the App:**
   ```bash
   flutter run
   ```

4. **Test Hot Reload:**
   - Change the increment value to 5
   - Press `r` in terminal to hot reload
   - Notice the app updates instantly

### What You'll Observe

- Tap the button → count increases instantly
- The UI responds reactively to state changes
- Hot Reload makes iteration fast
- No restart needed to see changes

### Connection to LiveToura

In LiveToura, similar reactive patterns will handle:
- Real-time score updates from Firestore
- Live leaderboard refreshes
- Player statistics updates
- Match status notifications

---

## Next Steps

1. ✅ Understand Flutter's three-layer architecture
2. ✅ Grasp widget hierarchy and types
3. ✅ Learn Dart fundamentals for UI development
4. ✅ Document StatelessWidget vs StatefulWidget
5. ⏳ Record 3-5 minute video walkthrough of Counter App
6. ⏳ Deploy first version of LiveToura app



## Video Explanation Checklist

When recording your 3-5 minute video walkthrough, cover:

- [ ] Show the Counter App running on Android/iOS simulator
- [ ] Explain StatefulWidget structure (Widget + State class)
- [ ] Demonstrate how `setState()` triggers re-renders
- [ ] Show the widget tree hierarchy
- [ ] Mention Hot Reload for fast iteration
- [ ] Explain why Dart's null safety matters
- [ ] Discuss Flutter's performance advantages
- [ ] Relate concepts to LiveToura's real-time requirements

**Upload to:** Google Drive (set sharing to "Anyone with the link can view")

---

## Resources

- [Flutter Official Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language)
- [Firebase with Flutter](https://firebase.flutter.dev/)
- [DartPad - Run Dart Online](https://dartpad.dev/)
- [Flutter Widget of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwZ3Km7sQZFTdB996iG)

---

**Last Updated:** February 6, 2026
**Status:** Concept-1 Documentation Complete


---

## Concept-2: Firebase Integration for Real-Time Mobile Applications

### Objective
Learn how Firebase enables authentication, database, and cloud storage integration in mobile apps, and understand how Cloud Firestore maintains real-time data synchronization between users and devices.

---

### 1. Firebase Setup

#### What is Firebase?
Firebase is Google's Backend-as-a-Service (BaaS) platform that provides:
- Authentication: Secure user sign-up, login, and session management
- Cloud Firestore: Real-time NoSQL database with automatic synchronization
- Cloud Storage: File storage for media (images, videos, documents)
- Cloud Functions: Serverless backend logic (optional)

**Last Updated:** February 10, 2026
**Status: Concept-2 (Firebase Integration) Complete

---

## Sprint 2 - Task 1: Understanding the Widget Tree and Reactive UI Model

### Project Title: Widget Tree & Reactive UI – Comprehensive Demo

This task demonstrates Flutter's core concept: **the widget tree** – a hierarchical structure of widgets that describes the entire UI – and **the reactive UI model** – how Flutter automatically rebuilds the affected parts of the tree when state changes.

---

### 🎯 Learning Objectives

1. **Understand the Widget Tree**: Learn how widgets nest hierarchically to form complex UIs
2. **Grasp the Reactive Model**: Understand how `setState()` triggers efficient UI updates
3. **StatefulWidget Mastery**: Know when and how to use `StatefulWidget` for interactive UIs
4. **Rendering Efficiency**: Understand why Flutter only rebuilds affected widgets
5. **Visual Demonstration**: Build interactive examples showing state-driven UI updates

---

### Part 1: Widget Tree Fundamentals

#### What is the Widget Tree?

In Flutter, **everything is a widget**. Widgets are the basic building blocks of Flutter UIs. They describe what a piece of the UI should look like given a particular configuration and state.

The **Widget Tree** is a hierarchical arrangement of these widgets, where:
- **Root Widget** is typically `MaterialApp` or `CupertinoApp`
- **Parent Widgets** contain **Child Widgets**
- Each branch represents a layer of UI structure
- Leaf nodes are typically simple widgets like `Text`, `Icon`, or `Image`

**Why This Matters:**
- Organizing widgets hierarchically makes complex UIs manageable
- Parent-child relationships determine layout and behavior
- Understanding the tree helps you reason about your app's structure

---

### Part 2: Complete Widget Tree Examples

#### Example 1: Simple Welcome Screen Widget Tree

```
MaterialApp (Entry Point - Root)
 ┗ WidgetTreeDemoApp (StatelessWidget)
    ┗ Scaffold (Material Design Layout)
       ├─ AppBar (Top Bar)
       │  ├─ Text ('Widget Tree & Reactive UI')
       ├─ Body (Main Content Area)
       │  ├─ Center (Centers children)
       │  │  └─ Column (Vertical Layout)
       │  │     ├─ Text ('Welcome to Tournament Tracker')
       │  │     ├─ SizedBox (Spacing)
       │  │     ├─ CircleAvatar (Profile Picture)
       │  │     ├─ Text (Name)
       │  │     ├─ ElevatedButton (Call to Action)
```

**Key Observations:**
- `MaterialApp` is the root - every Flutter Material app starts here
- `Scaffold` provides Material Design structure (AppBar, Body, FAB, Drawer)
- `Column` is a layout widget that arranges children vertically
- `SizedBox` adds spacing between widgets
- Leaf widgets (`Text`, `ElevatedButton`) are the visible content

#### Example 2: Reactive Profile Card with Toggle

```
ProfileCardDemo (StatefulWidget with bool _showDetails)
 ┗ Scaffold
    ├─ AppBar ('Profile Card Demo')
    └─ Body (Center)
       └─ Column
          ├─ Card (Material design container)
          │  └─ Padding
          │     └─ Column
          │        ├─ CircleAvatar (Profile Picture)
          │        ├─ Text ('Name') ← Always Visible
          │        ├─ if (_showDetails)  ← CONDITIONAL - Rebuilds!
          │        │  └─ Column
          │        │     ├─ Text ('Email')
          │        │     └─ Text ('Bio')
          │        └─ ElevatedButton ('Show/Hide Details') ← Triggers setState()
          └─ Explanation Container
             └─ Text (How Reactive Updates Work)
```

**Reactive Pattern Here:**
1. User taps ElevatedButton
2. `_toggle()` method called
3. `setState(() { _showDetails = !_showDetails; })`
4. Flutter detects state change
5. `build()` method re-executed
6. `if (_showDetails)` conditional re-evaluated
7. New widgets shown/hidden
8. **Only affected widgets rebuilt** (efficient!)

#### Example 3: Counter App Widget Tree

```
CounterAppDemo (StatefulWidget with int _count)
 ┗ Scaffold
    ├─ AppBar ('Counter App Demo')
    └─ Body (Center)
       └─ Column
          ├─ Text ('Button Press Counter')
          ├─ SizedBox (Spacing)
          ├─ Container (Counter Display Circle) [Rebuilds on setState]
          │  └─ Text ('$_count') ← REACTIVE - Changes with state!
          ├─ SizedBox (Spacing)
          └─ Row (Button Controls) [Static - doesn't rebuild often]
             ├─ ElevatedButton (Decrement) ← Calls setState()
             ├─ ElevatedButton (Reset) ← Calls setState()
             └─ ElevatedButton (Increment) ← Calls setState()
```

**Key Insight:**
- The `Text('$_count')` widget **rebuilds every time** the count changes
- The buttons and layout **don't rebuild** because they're static
- Flutter's element tree tracks which widgets need updating
- This targeted rebuilding is why Flutter is **efficient**

---

### Part 3: Understanding the Reactive UI Model

#### The Reactive Cycle Explained

```
1. USER INTERACTION
   └─ User taps a button

2. EVENT HANDLER
   └─ onPressed: () { _increment(); }

3. STATE MODIFICATION
   └─ _increment() calls: setState(() { count++; })

4. NOTIFICATION
   └─ Flutter's framework detects state change
   └─ Marks this widget as "dirty" (needs rebuild)

5. BUILD PHASE
   └─ Framework calls build() method again
   └─ build() returns new widget tree with updated values

6. ELEMENT TREE COMPARISON
   └─ Flutter compares old and new widget trees
   └─ Identifies which widgets actually changed
   └─ Only rebuilds the different widgets

7. RENDERING
   └─ Updated widgets are re-rendered to screen
   └─ User sees the change instantly

8. REPEAT
   └─ Cycle repeats for next user interaction
```

#### Why This is More Efficient Than Manual Updates

**Old Approach (Imperative UI):**
```dart
// Manually update UI element by element
counterText.text = newCount.toString();
counterText.color = newColor;
button.enabled = newState;
// ... manually update many elements
```

**Reactive Approach (Declarative UI):**
```dart
// Declare what UI should look like
Text('$count') // Flutter automatically updates when count changes
```

**Benefits of Reactive:**
- ✅ Less boilerplate code
- ✅ Fewer manual update bugs
- ✅ Automatic efficient rendering
- ✅ Clear relationship between state and UI

---

### Part 4: StatefulWidget vs StatelessWidget

| Aspect | StatelessWidget | StatefulWidget |
|--------|-----------------|----------------|
| **Mutability** | Immutable - never changes | Mutable state can change |
| **State** | No internal state | Has State class with mutable fields |
| **Rebuilds** | Only when constructor parameters change | When setState() is called |
| **Use Cases** | Static content, labels, icons | Forms, counters, toggles, real-time data |
| **Overhead** | Lightweight | Slightly more overhead |

#### StatefulWidget Structure

```dart
// 1. Widget class (immutable container)
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});
  
  @override
  State<CounterApp> createState() => _CounterAppState();
}

// 2. State class (holds mutable state)
class _CounterAppState extends State<CounterApp> {
  int count = 0; // ← Mutable state
  
  void increment() {
    setState(() {
      count++; // ← Call setState to trigger rebuild
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Text('Count: $count'); // ← Declares widget hierarchy
  }
}
```

**Why the separation?**
- Widget class is immutable (efficient, can be reused as constants)
- State class is mutable (holds changeable data)
- This design pattern allows Flutter to optimize rendering

---

### Part 5: Running the Comprehensive Demos

#### Option 1: Run Welcome Screen (Original Demo)
```bash
cd LiveToura
flutter run -t lib/main_widget_tree_demo.dart
```

#### Option 2: Run Comprehensive Demo (Recommended)
```bash
cd LiveToura
flutter run -t lib/widget_tree_comprehensive_demo.dart
```

**This includes 4 interactive demos:**
1. **Profile Card** - Toggle show/hide details (state management)
2. **Counter App** - Increment/decrement counter (reactive updates)
3. **Color Switcher** - Change theme colors dynamically
4. **Widget Tree Visualizer** - See the actual widget hierarchy

---

### Part 6: Interactive Examples in the Codebase

#### 1. Profile Card Demo
**Location:** `lib/widget_tree_comprehensive_demo.dart` → `ProfileCardDemo`

**Features:**
- Stateful toggle button
- Conditional widget rendering
- State-driven UI changes
- Example of efficient rebuilding

**What to Observe:**
- Press "Show Details" - only the details column rebuilds
- Press "Hide Details" - the column is removed from tree
- Buttons and avatar don't change (no rebuild)

#### 2. Counter App Demo
**Location:** `lib/widget_tree_comprehensive_demo.dart` → `CounterAppDemo`

**Features:**
- Multiple buttons with different actions
- Real-time count display
- Reset functionality

**What to Observe:**
- Press Increment/Decrement - only the count text updates
- The button layout stays the same
- Fresh rendering is instant (you're seeing the reactive model)

#### 3. Color Switcher Demo
**Location:** `lib/widget_tree_comprehensive_demo.dart` → `ColorSwitcherDemo`

**Features:**
- Multiple state variables (`_primaryColor`, `_secondaryColor`)
- All related widgets rebuild together

**What to Observe:**
- Click a color - AppBar, container, and text all update
- Demonstrates cascading state changes through the tree

#### 4. Widget Tree Visualizer
**Location:** `lib/widget_tree_comprehensive_demo.dart` → `WidgetTreeVisualizer`

**Features:**
- Visual representation of all demo widget trees
- Code structure shown as ASCII diagrams
- Key concepts explained

---

### Part 7: How to Take Screenshots for Documentation

#### Screenshots to Capture:

**Screenshot 1: Initial UI State**
```
Run the app:
flutter run -t lib/widget_tree_comprehensive_demo.dart

Navigate to "Profile Card" demo
Press screenshot key on your simulator/device
Label: "Initial Profile Card (Details Hidden)"
```

**Screenshot 2: After State Change**
```
Click "Show Details" button
Press screenshot key
Label: "Profile Card After Toggle (Details Visible)"
```

**Screenshot 3: Counter App Before**
```
Navigate to "Counter App" demo
Press screenshot key
Label: "Counter App Initial State (Count = 0)"
```

**Screenshot 4: Counter App After Interactions**
```
Click "Increase" button several times
Press screenshot key
Label: "Counter App After Multiple Increments (Count = 5)"
```

**Screenshot 5: Widget Tree Visualizer**
```
Navigate to "Widget Tree Visualizer" demo
Scroll to see all tree diagrams
Press screenshot key
Label: "Widget Tree Hierarchy Diagrams"
```

---

### Part 8: Key Takeaways & Reflection

#### What You Now Understand:

1. **Widget Tree Structure**
   - Everything in Flutter is a widget
   - Widgets form a hierarchical tree
   - Parent-child relationships determine layout

2. **Reactive UI Model**
   - setState() triggers rebuilds
   - Only affected widgets re-render
   - Efficient and automatic

3. **When to Use StatefulWidget**
   - When UI needs to respond to interaction
   - When you need to update the display
   - For forms, counters, toggles, real-time data

4. **Flutter's Rendering Pipeline**
   - Build phase: create widget tree
   - Element tree comparison: identify changes
   - Rendering: draw only updated widgets
   - Composite: combine layers

#### How This Applies to LiveToura:

- **Real-time Score Updates**: When a score changes in Firestore, StatefulWidget will rebuild to show new data
- **Live Leaderboards**: As players perform, their positions update reactively
- **Player Statistics**: Stats update automatically without manual UI manipulation
- **Match Notifications**: New match events trigger widget rebuilds

---

### Part 9: PR Submission Guidelines

#### Commit Message
```bash
git add .
git commit -m "feat: demonstrated widget tree and reactive UI model with state updates"
```

#### PR Title
```
[Sprint-2] Widget Tree & Reactive UI – LiveToura Team
```

#### PR Description
```markdown
## Summary
Demonstrated Flutter's widget tree structure and reactive UI model with interactive examples.

## Widget Hierarchy
See DESIGN_SPEC.md for complete widget tree diagrams.

## Demos Included
- Profile Card with toggle
- Counter App with increment/decrement
- Color Switcher with dynamic theming
- Widget Tree Visualizer

## Screenshots
[Attach screenshot showing initial UI state]
[Attach screenshot showing UI after state change]

## Key Learnings
- Widget tree is hierarchical structure of all UI elements
- setState() triggers efficient re-renders of affected widgets
- Only widgets with changed state rebuild (performance optimization)
- Reactive model is more efficient than manual UI manipulation

## How to Test
```bash
flutter run -t lib/widget_tree_comprehensive_demo.dart
```

Click through different demos to see the reactive updates in action.

## Video Demo
[Link to Google Drive video - 1-2 minutes]
Shows widget hierarchy, state changes, and reactive updates.
```

---

### Part 10: Recording Your Video Demo (1-2 Minutes)

**Checklist:**
- [ ] Open the app with: `flutter run -t lib/widget_tree_comprehensive_demo.dart`
- [ ] Demonstrate Profile Card demo - toggle details on/off
- [ ] Explain: "When I toggle, only the details column rebuilds"
- [ ] Navigate to Counter App
- [ ] Press Increment button several times
- [ ] Explain: "Only the count text rebuilds, not the buttons"
- [ ] Navigate to Widget Tree Visualizer
- [ ] Show the hierarchical structure
- [ ] Explain: "This is how Flutter organizes UI elements"
- [ ] Conclude: "The reactive model means I don't manually update UI - Flutter does it automatically"

**Upload to:**
- Google Drive (set to "Anyone with link - can view")
- YouTube (unlisted)
- Loom (shareable link)

**Add the link to your PR description**

---

### How to Run the Demo

To verify your understanding and see the reactive UI in action:

```bash
flutter run -t lib/widget_tree_comprehensive_demo.dart
```

---
---

## Sprint 2: Flutter & Dart Basics – Team LiveToura

### 1. Project Setup & Environment
The project has been successfully initialized with the Flutter SDK.
- **Flutter Version**: Checked via `flutter doctor`.
- **Project Created**: `flutter create LiveToura`.
- **Default App Replaced**: Modified `main.dart` and created `welcome_screen.dart`.

### 2. Folder Structure & Modular Design
A clean folder hierarchy is critical for scaling. Our structure:

```
lib/
├── main.dart          # Entry point & Theme configuration
├── models/            # Data models (e.g., Tournament, Player, Match)
├── screens/           # Individual UI screens (e.g., WelcomeScreen)
├── services/          # Business logic & external data handling
└── widgets/           # Resusable UI components
```

**Why this structure?**
- **Separation of Concerns**: keeps UI (`screens`, `widgets`) separate from logic (`services`, `models`).
- **Scalability**: New features can be added as new screens/models without cluttering existing files.
- **Maintainability**: Easy to locate specific code (e.g., "Where is the Player model?" -> `models/`).

### 3. Naming Conventions
- **File Names**: `snake_case` (e.g., `welcome_screen.dart`)
- **Class Names**: `PascalCase` (e.g., `WelcomeScreen`)
- **Variables**: `camelCase` (e.g., `primaryColor`)

### 4. Setup Instructions
1.  **Prerequisites**: Flutter SDK installed.
2.  **Run**:
    ```bash
    flutter pub get
    flutter run
    ```

### 5. Reflection
**What did I learn?**
Building the "Welcome" screen reinforced the Widget Tree concept. Every UI element is a widget, nested to create complex layouts. Using `StatefulWidget` allowed me to create interactive elements (the toggle button), contrasting with static content.

**How will this help later?**
Understanding the distinction between `Stateless` and `Stateful` widgets is crucial for managing real-time data updates in LiveToura (e.g., live score changes). The modular structure will keep the codebase organized as we add more complex features like Firebase integration.

### 6. Demo
*(Screenshot placeholder - to be added after running the app)*
```

---

## Sprint 2 - Task 2: Responsive Mobile Interfaces

### Project Title: Tournament Tracker – Responsive Dashboard

The "Responsive Dashboard" demonstrates how **Tournament Tracker** adapts its layout to different screen sizes, providing an optimal experience for both mobile and tablet users. Organizers can manage tournaments efficiently on a larger screen, while mobile users get a streamlined list view.

### Implementation Details

1.  **Responsive Layout**:
    -   **Mobile**: A single-column scrollable list for clear visibility on small screens.
    -   **Tablet**: A two-column layout with a side navigation rail and a grid view for match cards, utilizing the extra screen real estate.
2.  **Adaptive Widgets**:
    -   Used `MediaQuery` to determine the current screen width and switch high-level layouts.
    -   Implemented `LayoutBuilder` to make fine-grained layout decisions based on parent widget constraints.
    -   Used `Expanded` and `Flexible` to ensure content fills available space without overflowing.

### Code Snippets

**Using MediaQuery for Screen Detection:**

```dart
// Check screen width to determine device type
final size = MediaQuery.of(context).size;
final isTablet = size.width > 600;

// Use this boolean to toggle UI elements
Text(isTablet ? 'Welcome, Organizer!' : 'Hi there!');
```

**Using LayoutBuilder for Adaptive Content:**

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // Return Grid View for wider screens
      return GridView.builder(...);
    } else {
      // Return List View for narrower screens
      return ListView.builder(...);
    }
  },
)
```

### Reflection

**Challenges & Solutions:**
-   **Challenge**: Designing a layout that looks good on both 400px (phone) and 800px+ (tablet) widths without duplicating code.
    -   **Solution**: Extracted common widgets like `_buildMatchCard` so they can be reused in both the `ListView` and `GridView`.
-   **Challenge**: Handling navigation differently (Bottom Bar vs Side Rail).
    -   **Solution**: specific conditional checks (`isTablet ? ... : ...`) to render the appropriate navigation widget.

**Impact on Usability:**
Responsive design ensures that **Tournament Tracker** feels "native" on any device. Organizers often use tablets for managing games, so a dashboard that leverages that space for a grid view makes their job faster and easier compared to scrolling through a long list.

### Screenshots
*(Add screenshots of the app in Portrait (Phone) and Landscape/Tablet mode here)*

---

## Sprint 2 - Task 3: Firebase Integration (Auth & Firestore)

### Project Title: LiveToura – Connected & Secure

This feature enables secure user authentication (Sign Up/Login) and real-time data storage using Cloud Firestore. It transforms the app from a static UI into a connected platform where organizers can securely manage tournament data.

### Setup Instructions

1.  **Firebase Project**: Created a project in Firebase Console.
2.  **Configuration**: Added `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
3.  **Dependencies**:
    -   `firebase_core`: Core Firebase initialization.
    -   `firebase_auth`: User authentication management.
    -   `cloud_firestore`: NoSQL database for tournament data.

### Implementation Details

1.  **Authentication (`auth_service.dart`)**:
    -   Implemented `signUp` and `signIn` using `FirebaseAuth`.
    -   Used `authStateChanges()` stream to automatically redirect users based on login status.
2.  **Data Storage (`firestore_service.dart`)**:
    -   Created `users` collection to store profile data upon signup.
    -   Implemented CRUD operations for `tournaments` collection (Create, Read, Delete).
3.  **UI Integration**:
    -   **Login/Signup Screens**: Clean, validated input forms.
    -   **Home Screen**: Displays "Welcome [User]" and a real-time list/grid of Tournaments fetched from Firestore.
    -   **Create Tournament**: Added dialog to create new tournaments.

### Code Snippets

**Authentication Logic:**
```dart
Future<User?> signUp(String email, String password) async {
  try {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    return credential.user;
  } catch (e) {
    return null;
  }
}
```

**Real-time Firestore Data (Tournaments):**
```dart
StreamBuilder<QuerySnapshot>(
  stream: FirestoreService().getTournaments(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final tournaments = snapshot.data!.docs;
      return ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final data = tournaments[index].data() as Map<String, dynamic>;
          return ListTile(title: Text(data['name']));
        },
      );
    }
    return const CircularProgressIndicator();
  },
)
```

### Reflection

**Challenges:**
-   **State Management**: Handling the asynchronous nature of Firebase calls (awaiting login) while keeping the UI responsive (loading spinners) required careful state management.
-   **Error Handling**: Ensuring meaningful error messages (e.g., "Weak Password" or "Email already in use") are displayed to the user instead of generic crashes.

**Scalability:**
Firebase handles the backend infrastructure, allowing the app to scale from 10 to 10,000 users without us needing to manage servers. Cloud Firestore's real-time capabilities mean any score update by an organizer is instantly pushed to all connected fans.

### Screenshots
*(Add screenshots of Signup, Login, and Authenticated Dashboard here)*


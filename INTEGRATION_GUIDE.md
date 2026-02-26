# Integration Guide: Stateless/Stateful Widgets Demo

This guide explains how to integrate the **Stateless and Stateful Widgets Demo** into your LiveToura app.

## Quick Start

### Step 1: Import the Demo Screen

In any screen where you want to navigate to the demo, add this import:

```dart
import 'screens/stateless_stateful_demo.dart';
```

### Step 2: Add Navigation Button

Add a button or menu item that navigates to the demo:

```dart
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatelessStatefulDemoScreen(),
      ),
    );
  },
  child: const Text('View Widgets Demo'),
)
```

---

## Option A: Add to Welcome/Home Screen

### Edit welcome_screen.dart or your home screen

```dart
// Add this button to your existing screen

ElevatedButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatelessStatefulDemoScreen(),
      ),
    );
  },
  icon: const Icon(Icons.widgets),
  label: const Text('Widgets Demo'),
),
```

---

## Option B: Create a Tutorial/Learning Route

### Create a new screen for educational content

```dart
// Create: lib/screens/learning_hub.dart

import 'package:flutter/material.dart';
import 'stateless_stateful_demo.dart';
import 'other_demo.dart';

class LearningHubScreen extends StatelessWidget {
  const LearningHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Hub'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DemoCard(
            title: 'Stateless vs Stateful Widgets',
            description: 'Learn the fundamentals of Flutter widgets',
            icon: Icons.widgets,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatelessStatefulDemoScreen(),
                ),
              );
            },
          ),
          // Add more demo cards here
        ],
      ),
    );
  }
}

class DemoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const DemoCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
```

---

## Option C: Add to Main App Navigation

### Update main.dart with a new route

```dart
import 'screens/stateless_stateful_demo.dart';

class LiveTouraBasicsApp extends StatelessWidget {
  const LiveTouraBasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveToura',
      theme: LiveTouraTheme.lightTheme,
      home: const WelcomeScreen(),
      routes: {
        '/home': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/widgets-demo': (context) => const StatelessStatefulDemoScreen(),
        // Add other routes as needed
      },
    );
  }
}
```

Then navigate using named route:

```dart
Navigator.pushNamed(context, '/widgets-demo');
```

---

## Option D: Add Debug Banner Entry

Create a debug menu that shows available demos:

```dart
// In any development/debug screen

PopupMenuButton<String>(
  onSelected: (String route) {
    Navigator.pushNamed(context, route);
  },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      value: '/widgets-demo',
      child: Text('Widgets Demo'),
    ),
    // Add more demo options
  ],
  child: const Icon(Icons.menu),
),
```

---

## Navigation Pattern Example

### Full Screen Integration

```dart
// In your home or menu screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveToura'),
      ),
      body: Column(
        children: [
          // Other content
          const SizedBox(height: 16),
          SectionTitle('Learning & Education'),
          DemoTile(
            icon: Icons.widgets,
            title: 'Stateless & Stateful Widgets',
            subtitle: 'Flutter fundamentals explained with examples',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatelessStatefulDemoScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DemoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DemoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
```

---

## Testing Navigation

### Quick Test Steps

1. **Add the import** to your screen file
2. **Add a button or menu item** that navigates to the demo
3. **Run the app**: `flutter run`
4. **Tap the button** to navigate to the demo
5. **Interact** with all the buttons and inputs
6. **Press back** button to return to previous screen

---

## Common Navigation Patterns

### Pattern 1: Simple Button
```dart
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatelessStatefulDemoScreen(),
      ),
    );
  },
  child: const Text('View Demo'),
)
```

### Pattern 2: Floating Action Button
```dart
FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatelessStatefulDemoScreen(),
      ),
    );
  },
  child: const Icon(Icons.widgets),
)
```

### Pattern 3: ListTile
```dart
ListTile(
  leading: const Icon(Icons.widgets),
  title: const Text('Widgets Demo'),
  trailing: const Icon(Icons.arrow_forward),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatelessStatefulDemoScreen(),
      ),
    );
  },
)
```

### Pattern 4: Named Routes
```dart
onPressed: () {
  Navigator.pushNamed(context, '/widgets-demo');
}
```

---

## Troubleshooting

### Issue: "StatelessStatefulDemoScreen not found"
**Solution**: Make sure you've imported the demo file at the top of your screen:
```dart
import 'screens/stateless_stateful_demo.dart';
```

### Issue: Navigation not working
**Solution**: Verify you're using the correct context and that the route is properly registered

### Issue: Demo screen appears blank
**Solution**: Check your Flutter console for errors and ensure all dependencies are properly imported

---

## Next Steps

1. ✅ Add navigation to the demo screen
2. ✅ Run the app and verify it works
3. ✅ Take screenshots of the demo in action
4. ✅ Prepare the PR with the implementation
5. ✅ Record a video demo

---

## Files Modified

- `lib/screens/stateless_stateful_demo.dart` - Demo implementation
- `[Your screen file].dart` - Add navigation button (your choice which screen)

## Files Created

- `STATELESS_STATEFUL_README.md` - Complete documentation
- `INTEGRATION_GUIDE.md` - This file

---

Happy coding! 🚀

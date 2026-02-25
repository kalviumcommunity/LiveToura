import 'package:flutter/material.dart';

/// ============================================================
/// Widget Tree & Reactive UI Model - Comprehensive Demo
/// ============================================================
///
/// This demo showcases Flutter's widget tree structure and how
/// the reactive UI model automatically updates the interface
/// when state changes.
///
/// Key Concepts Demonstrated:
/// 1. Widget Tree Hierarchy - how widgets nest to form UI
/// 2. Stateful Widgets - maintaining mutable state
/// 3. setState() - triggering reactive re-renders
/// 4. Widget Rebuilding - efficient, targeted updates
///
/// ============================================================

void main() {
  runApp(const WidgetTreeDemoApp());
}

class WidgetTreeDemoApp extends StatelessWidget {
  const WidgetTreeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Tree & Reactive UI Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F51BA),
        ),
      ),
      home: const DemoHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// ============================================================
/// DEMO 1: Widget Tree Hierarchy Explorer
/// ============================================================
/// This screen shows different widget tree structures and
/// explains the parent-child relationships.

class DemoHomeScreen extends StatefulWidget {
  const DemoHomeScreen({super.key});

  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  int _selectedDemoIndex = 0;

  final List<(String title, String description, Widget Function() builder)>
      _demos = [
    (
      'Profile Card',
      'Toggle profile visibility - demonstrates state management',
      () => const ProfileCardDemo(),
    ),
    (
      'Counter App',
      'Increment/Decrement - shows setState() rebuilding widget tree',
      () => const CounterAppDemo(),
    ),
    (
      'Color Switcher',
      'Change theme colors - reactive UI model in action',
      () => const ColorSwitcherDemo(),
    ),
    (
      'Widget Tree Visualizer',
      'Visual representation of the actual widget hierarchy',
      () => const WidgetTreeVisualizer(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree & Reactive UI'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Demo Selector
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _demos.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_demos[index].$1),
                      selected: _selectedDemoIndex == index,
                      onSelected: (selected) {
                        setState(() => _selectedDemoIndex = index);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _demos[_selectedDemoIndex].$2,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          // Demo Content
          Expanded(
            child: _demos[_selectedDemoIndex].$3(),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// DEMO 2.1: Profile Card with Toggle (Reactive State Update)
/// ============================================================
/// Widget Tree:
///   ProfileCardDemo (StatefulWidget)
///    ├─ Scaffold
///    │  ├─ AppBar
///    │  └─ Body (Center)
///    │     └─ Column
///    │        ├─ Card (Profile Container)
///    │        │  └─ Padding
///    │        │     └─ Column
///    │        │        ├─ CircleAvatar (Profile Pic)
///    │        │        ├─ Text (Name)
///    │        │        ├─ Text (Email) [Conditional]
///    │        │        ├─ Text (Bio) [Conditional]
///    │        │        └─ ElevatedButton (Toggle)

class ProfileCardDemo extends StatefulWidget {
  const ProfileCardDemo({super.key});

  @override
  State<ProfileCardDemo> createState() => _ProfileCardDemoState();
}

class _ProfileCardDemoState extends State<ProfileCardDemo> {
  bool _showDetails = false;

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card Demo'),
        backgroundColor: const Color(0xFF1F51BA),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Card
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Name - Always Visible
                    Text(
                      'Alex Tournament Master',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Details - Shown Only When _showDetails = true
                    if (_showDetails)
                      Column(
                        children: [
                          Text(
                            'Email: alex@tournament.app',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Bio: Passionate about organizing community sports tournaments',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    // Toggle Button
                    ElevatedButton.icon(
                      onPressed: _toggleDetails,
                      icon: Icon(
                        _showDetails ? Icons.visibility_off : Icons.visibility,
                      ),
                      label: Text(
                        _showDetails ? 'Hide Details' : 'Show Details',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Explanation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How Reactive Updating Works Here:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1. Button Pressed → _toggleDetails() called\n'
                      '2. setState(() { _showDetails = !_showDetails; })\n'
                      '3. Flutter detects state change\n'
                      '4. build() method re-executed\n'
                      '5. if (_showDetails) conditional re-evaluated\n'
                      '6. UI updated with new widgets shown/hidden\n'
                      '7. Only affected widgets rebuilt (efficient!)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// DEMO 2.2: Counter App (Classic Stateful Widget Example)
/// ============================================================
/// Widget Tree:
///   CounterAppDemo (StatefulWidget)
///    ├─ Scaffold
///    │  ├─ AppBar
///    │  └─ Body (Center)
///    │     └─ Column
///    │        ├─ Text ("Count:")
///    │        ├─ Text ("$_count") [Reactive - rebuilt on setState]
///    │        └─ Row
///    │           ├─ ElevatedButton (Decrement)
///    │           ├─ SizedBox (Spacer)
///    │           └─ ElevatedButton (Increment)

class CounterAppDemo extends StatefulWidget {
  const CounterAppDemo({super.key});

  @override
  State<CounterAppDemo> createState() => _CounterAppDemoState();
}

class _CounterAppDemoState extends State<CounterAppDemo> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App Demo'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Button Press Counter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            // Counter Display - THIS REBUILDS when setState() is called
            Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$_count',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 48),
            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrease'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Increase'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            // Explanation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Reactive Cycle:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Each time you press a button:\n'
                      '• setState() is called with new count\n'
                      '• Flutter marks this widget as needing rebuild\n'
                      '• build() method runs again\n'
                      '• Only the Text displaying count rebuilds\n'
                      '• Buttons and layout stay the same (efficient)\n'
                      '• Screen reflects new count instantly',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// DEMO 2.3: Color Switcher (Multiple State Changes)
/// ============================================================
/// Demonstrates how changing state updates multiple widgets

class ColorSwitcherDemo extends StatefulWidget {
  const ColorSwitcherDemo({super.key});

  @override
  State<ColorSwitcherDemo> createState() => _ColorSwitcherDemoState();
}

class _ColorSwitcherDemoState extends State<ColorSwitcherDemo> {
  late Color _primaryColor;
  late Color _secondaryColor;
  String _colorName = 'Blue';

  @override
  void initState() {
    super.initState();
    _updateColors('blue');
  }

  void _updateColors(String colorName) {
    setState(() {
      _colorName = colorName;
      switch (colorName) {
        case 'blue':
          _primaryColor = const Color(0xFF1F51BA);
          _secondaryColor = const Color(0xFF6750A4);
          break;
        case 'orange':
          _primaryColor = const Color(0xFFFF6B35);
          _secondaryColor = const Color(0xFFFFB347);
          break;
        case 'green':
          _primaryColor = const Color(0xFF2D6A4F);
          _secondaryColor = const Color(0xFF52796F);
          break;
        case 'purple':
          _primaryColor = const Color(0xFF6A4C93);
          _secondaryColor = const Color(0xFF9D84B7);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Switcher Demo'),
        backgroundColor: _primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Color Display
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _primaryColor.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _colorName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Color Buttons
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: ['blue', 'orange', 'green', 'purple']
                  .map((color) => ElevatedButton(
                        onPressed: () => _updateColors(color),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          color.capitalize(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 48),
            // Explanation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: _primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Multiple Widget Updates:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'When you click a color button:\n'
                      '• setState() updates _primaryColor\n'
                      '• AppBar rebuilds with new color\n'
                      '• Container rebuilds with new color\n'
                      '• Text rebuilds with new color name\n'
                      '• Buttons stay the same (static content)\n'
                      '• This is the reactive model efficiency!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// DEMO 2.4: Widget Tree Visualizer
/// ============================================================
/// Shows the actual widget tree structure visually

class WidgetTreeVisualizer extends StatelessWidget {
  const WidgetTreeVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree Visualizer'),
        backgroundColor: const Color(0xFF6750A4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTreeSection(
              title: 'Welcome Screen Widget Tree',
              tree: [
                'MaterialApp (Root)',
                '└─ WidgetTreeDemoApp (Entry Point)',
                '   └─ Scaffold',
                '      ├─ AppBar',
                '      │  └─ Text("Widget Tree & Reactive UI")',
                '      ├─ Body',
                '      │  └─ Column',
                '      │     ├─ ChoiceChip (Demo Selectors)',
                '      │     ├─ Description Text',
                '      │     └─ Expanded (Demo Content)',
                '      │        └─ ProfileCardDemo / CounterAppDemo / ...',
              ],
            ),
            const SizedBox(height: 24),
            _buildTreeSection(
              title: 'Profile Card Demo Widget Tree',
              tree: [
                'ProfileCardDemo (StatefulWidget)',
                '└─ Scaffold',
                '   ├─ AppBar',
                '   │  └─ Text("Profile Card Demo")',
                '   └─ Body (Center)',
                '      └─ Column',
                '         ├─ Card',
                '         │  └─ Padding',
                '         │     └─ Column',
                '         │        ├─ CircleAvatar (Profile Picture)',
                '         │        ├─ Text("Name")',
                '         │        ├─ if (_showDetails) → Column',
                '         │        │  ├─ Text("Email")',
                '         │        │  └─ Text("Bio")',
                '         │        └─ ElevatedButton (Toggle)',
                '         └─ Explanation Container',
              ],
            ),
            const SizedBox(height: 24),
            _buildTreeSection(
              title: 'Counter App Widget Tree',
              tree: [
                'CounterAppDemo (StatefulWidget)',
                '└─ Scaffold',
                '   ├─ AppBar',
                '   │  └─ Text("Counter App Demo")',
                '   └─ Body (Center)',
                '      └─ Column',
                '         ├─ Text("Button Press Counter")',
                '         ├─ Container (Counter Display)',
                '         │  └─ Text("$_count") ← REBUILT on setState()',
                '         └─ Row (Control Buttons)',
                '            ├─ ElevatedButton (Decrease)',
                '            ├─ ElevatedButton (Reset)',
                '            └─ ElevatedButton (Increase)',
              ],
            ),
            const SizedBox(height: 24),
            _buildKeyConceptsBox(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeSection({
    required String title,
    required List<String> tree,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tree.join('\n'),
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 11,
              color: Color(0xFF1F51BA),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyConceptsBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎯 Key Concepts:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '1️⃣ Everything is a Widget\n'
            'Buttons, text, containers, rows, columns - all widgets!\n\n'
            '2️⃣ Hierarchical Structure (Widget Tree)\n'
            'Widgets nest inside each other, forming a tree from root (MaterialApp) to leaves (Text, Icon).\n\n'
            '3️⃣ Stateful vs Stateless\n'
            'StatefulWidget can change (mutable state), Stateless cannot (immutable).\n\n'
            '4️⃣ setState() Triggers Rebuilds\n'
            'When you call setState(), Flutter rebuilds only affected widgets.\n\n'
            '5️⃣ Efficient Rendering\n'
            'Flutter uses an Element tree to track which widgets need updating.\n'
            'Only rebuilds the widget subtree affected by the state change.\n\n'
            '6️⃣ Reactive Model\n'
            'Declare what UI should look like for given state.\n'
            'Flutter handles the re-rendering automatically.',
            style: TextStyle(
              fontSize: 12,
              height: 1.6,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper Extensions
extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

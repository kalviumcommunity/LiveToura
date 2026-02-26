import 'package:flutter/material.dart';

/// Main Demo Screen combining Stateless and Stateful widgets
class StatelessStatefulDemoScreen extends StatelessWidget {
  const StatelessStatefulDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widgets'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Stateless Widget Section
              const StatelessHeader(
                title: 'Stateless Widget Demo',
                description: 'This header never changes unless rebuilt by parent',
              ),
              const SizedBox(height: 16),
              const StaticInfoCard(
                icon: Icons.info,
                title: 'What is a Stateless Widget?',
                content:
                    'A StatelessWidget builds a UI that does not change. Once built, it cannot change until its parent rebuilds it with new properties.',
              ),
              const SizedBox(height: 24),

              // Stateful Widget Section
              const Divider(),
              const SizedBox(height: 16),
              const StatelessHeader(
                title: 'Stateful Widget Demo',
                description: 'Interactive elements below demonstrate state management',
              ),
              const SizedBox(height: 16),

              // Interactive Counter Widget
              const InteractiveCounterWidget(),
              const SizedBox(height: 24),

              // Color Changer Widget
              const ColorChangerWidget(),
              const SizedBox(height: 24),

              // Toggle Light/Dark Mode Widget
              const ThemeToggleWidget(),
              const SizedBox(height: 24),

              // Combined Interactive Widget
              const CombinedInteractiveWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== STATELESS WIDGETS ====================

/// Example Stateless Widget: Static Header
/// This widget displays static content that doesn't change
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
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}

/// Example Stateless Widget: Information Card
/// Displays static information in a card format
class StaticInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const StaticInfoCard({
    required this.icon,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== STATEFUL WIDGETS ====================

/// Example Stateful Widget: Interactive Counter
/// Demonstrates basic state management with increment/decrement
class InteractiveCounterWidget extends StatefulWidget {
  const InteractiveCounterWidget({super.key});

  @override
  State<InteractiveCounterWidget> createState() =>
      _InteractiveCounterWidgetState();
}

class _InteractiveCounterWidgetState extends State<InteractiveCounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Interactive Counter',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Count:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrease'),
                ),
                ElevatedButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Increase'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example Stateful Widget: Color Changer
/// Demonstrates state changes with color updates
class ColorChangerWidget extends StatefulWidget {
  const ColorChangerWidget({super.key});

  @override
  State<ColorChangerWidget> createState() => _ColorChangerWidgetState();
}

class _ColorChangerWidgetState extends State<ColorChangerWidget> {
  late Color _currentColor;
  late List<Color> _colorPalette;

  @override
  void initState() {
    super.initState();
    _colorPalette = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ];
    _currentColor = _colorPalette[0];
  }

  void _changeColor(int index) {
    setState(() {
      _currentColor = _colorPalette[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Color Changer',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: _currentColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _currentColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Current Color',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                _colorPalette.length,
                (index) => GestureDetector(
                  onTap: () => _changeColor(index),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: _colorPalette[index],
                      shape: BoxShape.circle,
                      border: _currentColor == _colorPalette[index]
                          ? Border.all(
                              color: Colors.black,
                              width: 3,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example Stateful Widget: Theme Toggle
/// Demonstrates toggling between two states
class ThemeToggleWidget extends StatefulWidget {
  const ThemeToggleWidget({super.key});

  @override
  State<ThemeToggleWidget> createState() => _ThemeToggleWidgetState();
}

class _ThemeToggleWidgetState extends State<ThemeToggleWidget> {
  bool _isLightMode = true;

  void _toggleTheme() {
    setState(() {
      _isLightMode = !_isLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isLightMode ? Colors.white : Colors.grey[900];
    final textColor = _isLightMode ? Colors.black : Colors.white;
    final iconColor = _isLightMode ? Colors.yellow : Colors.blue;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Theme Toggle',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _isLightMode ? Icons.light_mode : Icons.dark_mode,
                    color: iconColor,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isLightMode ? 'Light Mode' : 'Dark Mode',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleTheme,
              child: Text(
                _isLightMode ? 'Switch to Dark' : 'Switch to Light',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example Stateful Widget: Combined Interactive Widget
/// Demonstrates multiple state variables working together
class CombinedInteractiveWidget extends StatefulWidget {
  const CombinedInteractiveWidget({super.key});

  @override
  State<CombinedInteractiveWidget> createState() =>
      _CombinedInteractiveWidgetState();
}

class _CombinedInteractiveWidgetState extends State<CombinedInteractiveWidget>
    with SingleTickerProviderStateMixin {
  int _score = 0;
  bool _isVisible = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addPoints() {
    setState(() {
      _score += 10;
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _reset() {
    setState(() {
      _score = 0;
      _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Combined Interactive Demo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.2).animate(_animationController),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 300),
                  child: Column(
                    children: [
                      Text(
                        'Score: $_score',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isVisible ? 'Score Visible' : 'Score Hidden',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addPoints,
              child: const Text('Add 10 Points'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _toggleVisibility,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text(
                _isVisible ? 'Hide Score' : 'Show Score',
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _reset,
              child: const Text('Reset All'),
            ),
          ],
        ),
      ),
    );
  }
}

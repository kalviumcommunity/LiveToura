import 'package:flutter/material.dart';

/// DevTools Demonstration Screen
/// This screen demonstrates:
/// 1. Hot Reload - Change text, colors, and UI elements in real-time
/// 2. Debug Console - Uses debugPrint() to log events
/// 3. Flutter DevTools - Widget Inspector and Performance monitoring
class DevToolsDemoScreen extends StatefulWidget {
  const DevToolsDemoScreen({Key? key}) : super(key: key);

  @override
  State<DevToolsDemoScreen> createState() => _DevToolsDemoScreenState();
}

class _DevToolsDemoScreenState extends State<DevToolsDemoScreen> {
  int _counter = 0;
  String _statusMessage = 'Ready to demonstrate Flutter DevTools!';
  bool _showExtraWidget = false;

  @override
  void initState() {
    super.initState();
    debugPrint('=== DevTools Demo Screen Initialized ===');
    debugPrint('InitState called - Screen is now mounted');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _statusMessage = 'Counter incremented to $_counter';
      
      // Debug Console Output
      debugPrint('📊 Counter Updated: $_counter at ${DateTime.now()}');
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _statusMessage = 'Counter decremented to $_counter';
        
        // Debug Console Output
        debugPrint('📉 Counter Decreased: $_counter at ${DateTime.now()}');
      }
    });
  }

  void _toggleExtraWidget() {
    setState(() {
      _showExtraWidget = !_showExtraWidget;
      final action = _showExtraWidget ? 'shown' : 'hidden';
      _statusMessage = 'Extra widget $_action';
      
      // Debug Console Output
      debugPrint('🔄 Widget Toggle: Extra widget is now $_action');
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _statusMessage = 'Counter reset to 0';
      
      // Debug Console Output
      debugPrint('🔄 Reset Action: Counter reset by user at ${DateTime.now()}');
    });
  }

  @override
  void dispose() {
    debugPrint('=== DevTools Demo Screen Disposed ===');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🎨 Building DevToolsDemoScreen - Widget tree rebuild');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ Flutter DevTools Demo'),
        elevation: 4,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===== Section 1: Hot Reload Demo =====
              _buildSection(
                title: '1️⃣ Hot Reload Demonstration',
                icon: Icons.flash_on,
                backgroundColor: Colors.amber.shade50,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Try editing the text below and saving the file. Hot Reload will apply changes instantly without losing app state!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      border: Border.all(color: Colors.amber[700]!, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Welcome to Hot Reload! 🔥\n\n'
                      'Change this text, save the file with Ctrl+S, and watch it update instantly. '
                      'This is Hot Reload in action!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      debugPrint('ℹ️ Hot Reload Info Button Pressed');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hot Reload preserves app state while updating UI!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info),
                    label: const Text('About Hot Reload'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== Section 2: Debug Console Demo =====
              _buildSection(
                title: '2️⃣ Debug Console Demonstration',
                icon: Icons.bug_report,
                backgroundColor: Colors.teal.shade50,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Click the buttons below and watch the Debug Console (terminal) for log messages.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      border: Border.all(color: Colors.teal[700]!, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Counter Value:',
                          style: TextStyle(fontSize: 14, color: Colors.teal),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$_counter',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _statusMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal[900],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add),
                        label: const Text('Increment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _decrementCounter,
                        icon: const Icon(Icons.remove),
                        label: const Text('Decrement'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _resetCounter,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    '💡 Tip: Open the Debug Console and watch for log messages (look for emoji prefixes like 📊, 📉, 🔄)',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== Section 3: DevTools Widget Inspector Demo =====
              _buildSection(
                title: '3️⃣ Flutter DevTools - Widget Inspector',
                icon: Icons.architecture,
                backgroundColor: Colors.purple.shade50,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Open Flutter DevTools to inspect this widget tree and modify properties in real-time.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      border: Border.all(color: Colors.purple[700]!, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🏗️ Active Widget Tree:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.white,
                          child: const Text(
                            '''DevToolsDemoScreen (StatefulWidget)
  └─ _DevToolsDemoScreenState
      └─ Scaffold
          ├─ AppBar
          │   └─ Text('🛠️ Flutter DevTools Demo')
          └─ Body (SingleChildScrollView)
              └─ Column
                  ├─ Section 1: Hot Reload
                  ├─ Section 2: Debug Console
                  ├─ Section 3: DevTools Inspector
                  └─ Section 4: Performance Tools''',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Courier',
                              color: Colors.purple[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _toggleExtraWidget,
                    icon: const Icon(Icons.add_box),
                    label: Text(_showExtraWidget ? 'Hide Extra Widget' : 'Show Extra Widget'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700],
                      foregroundColor: Colors.white,
                    ),
                  ),
                  if (_showExtraWidget) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.purple[200],
                        border: Border.all(color: Colors.purple[900]!, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.widgets, size: 32, color: Colors.purple),
                          SizedBox(height: 8),
                          Text(
                            'Extra Widget Added!\n\nInspect this in DevTools Widget Inspector to see dynamic widget additions.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),

              // ===== Section 4: Performance Measurement Demo =====
              _buildSection(
                title: '4️⃣ Flutter DevTools - Performance Tab',
                icon: Icons.show_chart,
                backgroundColor: Colors.green.shade50,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Use DevTools Performance tab to monitor frame rendering and identify bottlenecks.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      border: Border.all(color: Colors.green[700]!, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '⚡ Performance Metrics:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildMetricRow('Frame Rate Target', '60 FPS'),
                        _buildMetricRow('Build Time', '< 16ms ideal'),
                        _buildMetricRow('Memory Usage', 'Monitor in DevTools'),
                        _buildMetricRow('Widget Count', 'Check Inspector'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      debugPrint('📈 Performance Info Button Pressed');
                      debugPrint('Current Widget State: $_showExtraWidget');
                      debugPrint('Counter Value: $_counter');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Performance metrics logged to Debug Console!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.analytics),
                    label: const Text('Log Performance Metrics'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== Instructions Section =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue[700]!, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📚 How to Use These Tools:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionItem(
                      '1. Hot Reload',
                      'Press "r" in terminal or click Hot Reload button. Edit text/colors above and save.',
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionItem(
                      '2. Debug Console',
                      'View logs in terminal/Debug Console. Look for emoji-prefixed messages.',
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionItem(
                      '3. DevTools Widget Inspector',
                      'Click the inspector icon in DevTools and tap widgets on screen to inspect them.',
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionItem(
                      '4. Performance Tab',
                      'Monitor frame rendering, build times, and memory usage in real-time.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey[300]!, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

# Advanced Extensions: Build Your Own Stateful Widgets

This guide shows how to extend the demo with additional custom interactive widgets.

---

## Template: Creating a New Stateful Widget

### Basic Structure

```dart
class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  // 1. Declare state variables
  String _currentValue = 'initial';

  // 2. Define update methods
  void _updateValue(String newValue) {
    setState(() {
      _currentValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. Build UI using state variables
    return Card(
      child: Column(
        children: [
          Text(_currentValue),
          ElevatedButton(
            onPressed: () => _updateValue('updated'),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
```

---

## Extension Ideas

### 1. Rating Widget (★★★★☆)

```dart
class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Rate This Demo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () => _setRating(index + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.star,
                      size: 40,
                      color: index < _rating ? Colors.amber : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _rating == 0 ? 'No rating' : 'You rated: $_rating stars',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 2. Slider Widget (Volume Control)

```dart
class VolumeControlWidget extends StatefulWidget {
  const VolumeControlWidget({super.key});

  @override
  State<VolumeControlWidget> createState() => _VolumeControlWidgetState();
}

class _VolumeControlWidgetState extends State<VolumeControlWidget> {
  double _volume = 50;
  bool _isMuted = false;

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value;
      if (value > 0) _isMuted = false;
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Volume Control',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: _toggleMute,
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: primary,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _isMuted ? 0 : _volume,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: _setVolume,
                  ),
                ),
                Text('${_volume.round()}%'),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _isMuted ? '🔇 Muted' : '${_volume.round()}% Volume',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 3. Selection List (Multiple Choices)

```dart
class SelectionListWidget extends StatefulWidget {
  const SelectionListWidget({super.key});

  @override
  State<SelectionListWidget> createState() => _SelectionListWidgetState();
}

class _SelectionListWidgetState extends State<SelectionListWidget> {
  final List<String> _options = [
    'Flutter',
    'Dart',
    'Firebase',
    'Widgets',
  ];

  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.filled(_options.length, false);
  }

  void _toggleOption(int index) {
    setState(() {
      _selected[index] = !_selected[index];
    });
  }

  void _clearAll() {
    setState(() {
      _selected = List<bool>.filled(_options.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = _selected.where((s) => s).length;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Topics',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '$count selected',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              return CheckboxListTile(
                title: Text(option),
                value: _selected[idx],
                onChanged: (value) => _toggleOption(idx),
                contentPadding: EdgeInsets.zero,
              );
            }),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _clearAll,
              child: const Text('Clear Selection'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 4. Stopwatch/Timer Widget

```dart
class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  int _seconds = 0;
  bool _isRunning = false;
  late Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStop() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
      _isRunning = !_isRunning;
    });

    if (_isRunning) {
      _updateTimer();
    }
  }

  void _reset() {
    setState(() {
      _stopwatch.reset();
      _seconds = 0;
      _isRunning = false;
    });
  }

  void _updateTimer() {
    if (_isRunning) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _seconds = _stopwatch.elapsedMilliseconds ~/ 1000;
        });
        _updateTimer();
      });
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Stopwatch',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _formatTime(_seconds),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _startStop,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }
}
```

---

### 5. Text Input Widget

```dart
class TextInputDemoWidget extends StatefulWidget {
  const TextInputDemoWidget({super.key});

  @override
  State<TextInputDemoWidget> createState() => _TextInputDemoWidgetState();
}

class _TextInputDemoWidgetState extends State<TextInputDemoWidget> {
  late TextEditingController _controller;
  String _displayText = 'Enter text above';
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateDisplay() {
    setState(() {
      _displayText = _controller.text.isEmpty
          ? 'Enter text above'
          : _controller.text;
      _charCount = _controller.text.length;
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _displayText = 'Enter text above';
      _charCount = 0;
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Text Input Demo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              onChanged: (_) => _updateDisplay(),
              decoration: InputDecoration(
                hintText: 'Type something...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixText: '$_charCount characters',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: Text(
                _displayText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _clear,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## How to Add These to Your Demo

### Option 1: Create a New File

Create `lib/screens/extended_widgets_demo.dart`:

```dart
import 'package:flutter/material.dart';

class ExtendedWidgetsDemoScreen extends StatelessWidget {
  const ExtendedWidgetsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extended Widgets Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const RatingWidget(),
            const SizedBox(height: 16),
            const VolumeControlWidget(),
            const SizedBox(height: 16),
            const SelectionListWidget(),
            const SizedBox(height: 16),
            const StopwatchWidget(),
            const SizedBox(height: 16),
            const TextInputDemoWidget(),
          ],
        ),
      ),
    );
  }
}

// Paste widget classes here...
```

### Option 2: Add to Existing Demo

Add these widgets to the main `StatelessStatefulDemoScreen`:

```dart
// Inside StatelessStatefulDemoScreen build()
Column(
  children: [
    // ... existing widgets ...
    const Divider(),
    const SizedBox(height: 16),
    const StatelessHeader(
      title: 'Extended Widgets',
      description: 'More examples of Stateful widgets',
    ),
    const SizedBox(height: 16),
    const RatingWidget(),
    const SizedBox(height: 16),
    const VolumeControlWidget(),
    // ... add more as desired ...
  ],
),
```

---

## Testing Custom Widgets

### Checklist for New Widgets

- [ ] Widget builds without errors
- [ ] All state variables initialized properly
- [ ] setState() called when state changes
- [ ] UI updates when state changes
- [ ] No memory leaks (dispose controllers if needed)
- [ ] Works on different screen sizes
- [ ] Responsive and interactive

---

## Advanced Techniques

### Using initState() for Setup
```dart
@override
void initState() {
  super.initState();
  // Initialize controllers, listeners, etc.
  _controller = TextEditingController();
}
```

### Using dispose() for Cleanup
```dart
@override
void dispose() {
  _controller.dispose();
  _timer.cancel();
  super.dispose();
}
```

### Multiple setState() Calls
```dart
void _updateMultiple() {
  setState(() {
    _count++;
    _message = 'Count is $_count';
    _color = Colors.blue;
  });
}
```

### Conditional UI Based on State
```dart
@override
Widget build(BuildContext context) {
  return _count > 10
      ? const Text('Count is high!')
      : const Text('Count is low');
}
```

---

## Going Further

1. **Add animations**: Use AnimationController for smooth transitions
2. **Implement validation**: Check input before updating state
3. **Store data**: Persist state using local storage
4. **Network calls**: Fetch data and update state
5. **Provider integration**: Use Provider for state management

---

## Challenge Ideas

1. **Build a todo app**: Add/remove items from list
2. **Create a calculator**: Perform math operations
3. **Make a game**: Track score and game state
4. **Implement a form**: Validate user input
5. **Build a settings screen**: Toggle app preferences

---

**Remember**: Every interactive feature in Flutter is powered by Stateful widgets managing state! 🚀

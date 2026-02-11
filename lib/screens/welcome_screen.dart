import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _toggled = false;

  void _toggle() {
    setState(() {
      _toggled = !_toggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tournament Tracker',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: _toggled ? secondary : primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Icon(
                Icons.sports_score,
                size: 96,
                color: _toggled ? primary : secondary,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _toggle,
                child: Text(_toggled ? 'Toggle Off' : 'Toggle On'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

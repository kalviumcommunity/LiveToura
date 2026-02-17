import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const WidgetTreeDemoApp());
}

class WidgetTreeDemoApp extends StatelessWidget {
  const WidgetTreeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Tree Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F51BA)),
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

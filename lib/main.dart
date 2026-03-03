import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_home.dart';
import 'screens/login_screen.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/dev_tools_demo.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/responsive_layout.dart';
import 'screens/scrollable_views.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LiveTouraBasicsApp());
}

// ==================== Theme & Design System ====================

class LiveTouraTheme {
  // Material 3 Color Palette
  static const Color primaryColor = Color(0xFF1F51BA);
  static const Color secondaryColor = Color(0xFF6750A4);
  static const Color tertiaryColor = Color(0xFFFF6B35);
  static const Color errorColor = Color(0xFFB3261E);
  static const Color surfaceColor = Color(0xFFFFFBFE);
  static const Color onSurfaceColor = Color(0xFF1C1B1F);

  // Design System Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        error: errorColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: surfaceColor,
        foregroundColor: onSurfaceColor,
      ),
      /*
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      */
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(56, 56),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ==================== Responsive Utilities ====================

class ResponsiveLayout {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 900;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  static double getPadding(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 24;
    return 32;
  }

  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}

class LiveTouraBasicsApp extends StatelessWidget {
  const LiveTouraBasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🚀 LiveToura App Started - Debug Console Open');
    return MaterialApp(
      title: 'LiveToura',
      theme: LiveTouraTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const DemoLauncherScreen(),
        '/home': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/responsive': (context) => const ResponsiveLayout(),
        '/scrollable': (context) => const ScrollableViews(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Demo Launcher Screen - Quick access to DevTools Demo
class DemoLauncherScreen extends StatelessWidget {
  const DemoLauncherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚀 LiveToura - Development Tools Demo'),
        elevation: 4,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flutter_dash,
                size: 80,
                color: Colors.blue.shade700,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to DevTools Demo',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Learn how to use Hot Reload, Debug Console, and Flutter DevTools effectively',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('🎯 User clicked - Navigating to DevTools Demo Screen');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DevToolsDemoScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.build),
                label: const Text('Open DevTools Demo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('🏠 User clicked - Navigating to Multi-Screen Navigation Demo');
                  Navigator.pushNamed(context, '/home');
                },
                icon: const Icon(Icons.navigation),
                label: const Text('Multi-Screen Navigation Demo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('� User clicked - Navigating to Responsive Layout Demo');
                  Navigator.pushNamed(context, '/responsive');
                },
                icon: const Icon(Icons.dashboard_customize),
                label: const Text('Responsive Layout Demo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.orange.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('📜 User clicked - Navigating to Scrollable Views Demo');
                  Navigator.pushNamed(context, '/scrollable');
                },
                icon: const Icon(Icons.view_agenda),
                label: const Text('Scrollable Views Demo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.deepPurple.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('🔐📋 User clicked - Navigating to Firebase Login');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text('Go to Login'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.grey.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

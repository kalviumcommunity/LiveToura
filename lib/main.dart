import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LiveTouraApp());
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
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
      ),
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

class LiveTouraApp extends StatelessWidget {
  const LiveTouraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveToura - Tournament Tracking',
      theme: LiveTouraTheme.lightTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const TournamentHomePage();
          }
          return const AuthenticationPage();
        },
      ),
    );
  }
}

// ==================== Authentication Service ====================

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      return 'Password is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'Account already exists for that email.';
    } else if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided.';
    }
    return e.message ?? 'Authentication error occurred.';
  }
}

// ==================== Firestore Service ====================

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTournament(String name, String sport) async {
    await _db.collection('tournaments').add({
      'name': name,
      'sport': sport,
      'createdAt': Timestamp.now(),
      'createdBy': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  Stream<QuerySnapshot> getTournamentsStream() {
    return _db
        .collection('tournaments')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addMatch(
    String tournamentId,
    String team1,
    String team2,
  ) async {
    await _db
        .collection('tournaments')
        .doc(tournamentId)
        .collection('matches')
        .add({
      'team1': team1,
      'team2': team2,
      'team1Score': 0,
      'team2Score': 0,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getMatchesStream(String tournamentId) {
    return _db
        .collection('tournaments')
        .doc(tournamentId)
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateMatchScore(
    String tournamentId,
    String matchId,
    int team1Score,
    int team2Score,
  ) async {
    await _db
        .collection('tournaments')
        .doc(tournamentId)
        .collection('matches')
        .doc(matchId)
        .update({
      'team1Score': team1Score,
      'team2Score': team2Score,
    });
  }
}

// ==================== Authentication Page ====================

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  bool _isSignUp = false;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    setState(() => _isLoading = true);
    try {
      if (_isSignUp) {
        await _authService.signUp(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await _authService.signIn(
          _emailController.text,
          _passwordController.text,
        );
      }
      setState(() => _errorMessage = null);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final padding = ResponsiveLayout.getPadding(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  // Logo/Title
                  Text(
                    'LiveToura',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: LiveTouraTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Real-Time Tournament Tracking',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Form Card
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          Text(
                            _isSignUp ? 'Create Account' : 'Sign In',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),
                          // Email Field
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          // Password Field
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 24),
                          // Error Message
                          if (_errorMessage != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: LiveTouraTheme.errorColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: LiveTouraTheme.errorColor,
                                ),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(
                                  color: LiveTouraTheme.errorColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          if (_errorMessage != null)
                            const SizedBox(height: 16),
                          // Sign In/Up Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _authenticate,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Toggle Sign In/Up
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSignUp = !_isSignUp;
                                _errorMessage = null;
                              });
                            },
                            child: Text(
                              _isSignUp
                                  ? 'Already have an account? Sign In'
                                  : 'Don\'t have an account? Sign Up',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== Tournament Home Page ====================

class TournamentHomePage extends StatefulWidget {
  const TournamentHomePage({Key? key}) : super(key: key);

  @override
  State<TournamentHomePage> createState() => _TournamentHomePageState();
}

class _TournamentHomePageState extends State<TournamentHomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _tournamentNameController =
      TextEditingController();
  final TextEditingController _sportController = TextEditingController();

  @override
  void dispose() {
    _tournamentNameController.dispose();
    _sportController.dispose();
    super.dispose();
  }

  void _showAddTournamentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Tournament'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _tournamentNameController,
              decoration: const InputDecoration(labelText: 'Tournament Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _sportController,
              decoration: const InputDecoration(labelText: 'Sport Type'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _firestoreService.addTournament(
                _tournamentNameController.text,
                _sportController.text,
              );
              _tournamentNameController.clear();
              _sportController.clear();
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveLayout.getPadding(context);
    final columns = ResponsiveLayout.getGridColumns(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveToura Tournaments'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _authService.signOut(),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getTournamentsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sports_score,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tournaments yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to create one',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            );
          }

          final tournaments = snapshot.data!.docs;
          return Padding(
            padding: EdgeInsets.all(padding),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                final tournament = tournaments[index];
                return TournamentCard(
                  tournament: tournament,
                  firestoreService: _firestoreService,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTournamentDialog,
        icon: const Icon(Icons.add),
        label: const Text('Add Tournament'),
      ),
    );
  }
}

// ==================== Tournament Card & Matches View ====================

class TournamentCard extends StatelessWidget {
  final QueryDocumentSnapshot tournament;
  final FirestoreService firestoreService;

  const TournamentCard({
    Key? key,
    required this.tournament,
    required this.firestoreService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TournamentDetailsPage(
                tournament: tournament,
                firestoreService: firestoreService,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tournament Name
              Text(
                tournament['name'],
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Sport Type
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: LiveTouraTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tournament['sport'],
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: LiveTouraTheme.primaryColor,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              // Live Badge
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'LIVE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF4CAF50),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: LiveTouraTheme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TournamentDetailsPage extends StatefulWidget {
  final QueryDocumentSnapshot tournament;
  final FirestoreService firestoreService;

  const TournamentDetailsPage({
    Key? key,
    required this.tournament,
    required this.firestoreService,
  }) : super(key: key);

  @override
  State<TournamentDetailsPage> createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage> {
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  int _selectedTabIndex = 0;

  @override
  void dispose() {
    _team1Controller.dispose();
    _team2Controller.dispose();
    super.dispose();
  }

  void _showAddMatchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Match'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _team1Controller,
              decoration: const InputDecoration(labelText: 'Team 1'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _team2Controller,
              decoration: const InputDecoration(labelText: 'Team 2'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.firestoreService.addMatch(
                widget.tournament.id,
                _team1Controller.text,
                _team2Controller.text,
              );
              _team1Controller.clear();
              _team2Controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final padding = ResponsiveLayout.getPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tournament['name']),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              onTap: (index) => setState(() => _selectedTabIndex = index),
              tabs: const [
                Tab(text: 'Matches'),
                Tab(text: 'Standings'),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildMatchesView(context, padding)
                : _buildStandingsView(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddMatchDialog,
        icon: const Icon(Icons.add),
        label: const Text('Add Match'),
      ),
    );
  }

  Widget _buildMatchesView(BuildContext context, double padding) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.firestoreService.getMatchesStream(widget.tournament.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No matches yet',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        final isMobile = ResponsiveLayout.isMobile(context);
        final matches = snapshot.data!.docs;
        final columns = isMobile ? 1 : 2;

        return Padding(
          padding: EdgeInsets.all(padding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return MatchCard(
                tournament: widget.tournament,
                match: match,
                firestoreService: widget.firestoreService,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStandingsView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.firestoreService.getMatchesStream(widget.tournament.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Tournament Standings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    ..._buildStandingsList(snapshot.data!.docs),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildStandingsList(List<QueryDocumentSnapshot> matches) {
    Map<String, int> teamScores = {};

    for (var match in matches) {
      String team1 = match['team1'];
      String team2 = match['team2'];
      int score1 = match['team1Score'];
      int score2 = match['team2Score'];

      teamScores[team1] = (teamScores[team1] ?? 0) + score1;
      teamScores[team2] = (teamScores[team2] ?? 0) + score2;
    }

    var sortedTeams = teamScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return [
      ...sortedTeams.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${entry.key + 1}. ${entry.value.key}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Card(
                    color: LiveTouraTheme.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        '${entry.value.value} pts',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    ];
  }
}

class MatchCard extends StatelessWidget {
  final QueryDocumentSnapshot tournament;
  final QueryDocumentSnapshot match;
  final FirestoreService firestoreService;

  const MatchCard({
    Key? key,
    required this.tournament,
    required this.match,
    required this.firestoreService,
  }) : super(key: key);

  void _updateScore(int team1Score, int team2Score) {
    firestoreService.updateMatchScore(
      tournament.id,
      match.id,
      team1Score,
      team2Score,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Match Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Team 1
                  Text(
                    match['team1'],
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Scores
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${match['team1Score']}',
                        style:Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: LiveTouraTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'VS',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey[500],
                            ),
                      ),
                      Text(
                        '${match['team2Score']}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: LiveTouraTheme.tertiaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Team 2
                  Text(
                    match['team2'],
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Divider(),
            // Score Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _updateScore(
                          match['team1Score'] + 1,
                          match['team2Score'],
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('+1'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LiveTouraTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _updateScore(
                          match['team1Score'],
                          match['team2Score'] + 1,
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('+1'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LiveTouraTheme.tertiaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


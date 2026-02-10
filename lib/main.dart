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

class LiveTouraApp extends StatelessWidget {
  const LiveTouraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveToura - Tournament Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
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

  // Add a new tournament
  Future<void> addTournament(String name, String sport) async {
    await _db.collection('tournaments').add({
      'name': name,
      'sport': sport,
      'createdAt': Timestamp.now(),
      'createdBy': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  // Get tournaments as a Stream for real-time updates
  Stream<QuerySnapshot> getTournamentsStream() {
    return _db
        .collection('tournaments')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Add a match to a tournament
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

  // Get matches for a tournament
  Stream<QuerySnapshot> getMatchesStream(String tournamentId) {
    return _db
        .collection('tournaments')
        .doc(tournamentId)
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Update match score
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveToura Authentication'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LiveToura',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isSignUp ? 'Create Account' : 'Sign In',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red[100],
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _authenticate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                ),
              ),
              const SizedBox(height: 16),
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
        title: const Text('Add Tournament'),
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
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveToura Tournaments'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authService.signOut();
            },
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
            return const Center(
              child: Text('No tournaments yet. Create one to get started!'),
            );
          }
          final tournaments = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tournaments.length,
            itemBuilder: (context, index) {
              final tournament = tournaments[index];
              return TournamentCard(
                tournament: tournament,
                firestoreService: _firestoreService,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTournamentDialog,
        child: const Icon(Icons.add),
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
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(tournament['name']),
        subtitle: Text('Sport: ${tournament['sport']}'),
        trailing: const Icon(Icons.arrow_forward),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tournament['name']),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.firestoreService.getMatchesStream(widget.tournament.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No matches yet. Add one to get started!'),
            );
          }
          final matches = snapshot.data!.docs;
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return MatchTile(
                tournament: widget.tournament,
                match: match,
                firestoreService: widget.firestoreService,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMatchDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MatchTile extends StatelessWidget {
  final QueryDocumentSnapshot tournament;
  final QueryDocumentSnapshot match;
  final FirestoreService firestoreService;

  const MatchTile({
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
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        match['team1'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${match['team1Score']}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('VS', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        match['team2'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${match['team2Score']}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _updateScore(match['team1Score'] + 1, match['team2Score']);
                  },
                  child: const Text('Team 1 +1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateScore(match['team1Score'], match['team2Score'] + 1);
                  },
                  child: const Text('Team 2 +1'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


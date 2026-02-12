import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign Up
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('SignUp Error: ${e.code} - ${e.message}');
      throw e; // Rethrow to handle in UI
    } catch (e) {
      print('SignUp Error: $e');
      return null;
    }
  }

  // Log In
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('SignIn Error: ${e.code} - ${e.message}');
      throw e;
    } catch (e) {
      print('SignIn Error: $e');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

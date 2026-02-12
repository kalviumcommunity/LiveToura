import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection Reference
  CollectionReference get users => _db.collection('users');
  CollectionReference get tournaments => _db.collection('tournaments');

  // Create User Data (after signup)
  Future<void> createUserData(String uid, String email, String name) async {
    try {
      await users.doc(uid).set({
        'uid': uid,
        'email': email, 
        'displayName': name,
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'organizer', // Default role
      });
    } catch (e) {
      print('Error creating user data: $e');
      throw e;
    }
  }

  // Get User Data
  Stream<DocumentSnapshot> getUserData(String uid) {
    return users.doc(uid).snapshots();
  }

  // Create Tournament
  Future<void> createTournament(String name, String type) async {
    try {
      await tournaments.add({
        'name': name,
        'type': type,
        'status': 'upcoming',
        'createdAt': FieldValue.serverTimestamp(),
        'participants': [],
      });
    } catch (e) {
      print('Error creating tournament: $e');
      throw e;
    }
  }

  // Get All Tournaments (Real-time)
  Stream<QuerySnapshot> getTournaments() {
    return tournaments.orderBy('createdAt', descending: true).snapshots();
  }

  // Update Tournament Status
  Future<void> updateTournamentStatus(String docId, String status) async {
    try {
      await tournaments.doc(docId).update({'status': status});
    } catch (e) {
      print('Error updating tournament: $e');
      throw e;
    }
  }

  // Delete Tournament
  Future<void> deleteTournament(String docId) async {
    try {
      await tournaments.doc(docId).delete();
    } catch (e) {
      print('Error deleting tournament: $e');
      throw e;
    }
  }
}

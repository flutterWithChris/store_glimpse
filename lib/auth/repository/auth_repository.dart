import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email and Password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception('Error signing up with email and password');
    }
  }

  // Sign In with Email and Password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception('Error signing in with email and password');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out');
    }
  }

  // Listen to user changes
  Stream<User?> get user => _auth.authStateChanges();

  // Delete user
  Future<void> deleteUser() async {
    try {
      return await _auth.currentUser!.delete();
    } catch (e) {
      throw Exception('Error deleting user');
    }
  }
}

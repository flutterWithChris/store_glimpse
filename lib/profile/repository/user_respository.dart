import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toDocument());
    } catch (e) {
      throw Exception('Error creating user');
    }
  }

  Stream<User> getUser(String id) {
    return _firestore
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) => User.fromDocument(snapshot));
  }

  Future<void> updateUser(User user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .update(user.toDocument());
    } catch (e) {
      throw Exception('Error updating user');
    }
  }

  Future<void> deleteUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).delete();
    } catch (e) {
      throw Exception('Error deleting user');
    }
  }
}

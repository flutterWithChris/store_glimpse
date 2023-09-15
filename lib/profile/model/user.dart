import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  User({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  // toDocument
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  // fromDocument
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
    );
  }
}

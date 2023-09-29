import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? paymentStatus;
  final String? paymentIntentID;
  final String? checkoutSessionID;

  User({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.paymentStatus,
    this.paymentIntentID,
    this.checkoutSessionID,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? paymentStatus,
    String? paymentIntentID,
    String? checkoutSessionID,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentIntentID: paymentIntentID ?? this.paymentIntentID,
      checkoutSessionID: checkoutSessionID ?? this.checkoutSessionID,
    );
  }

  // toDocument
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'paymentStatus': paymentStatus,
      'paymentIntentID': paymentIntentID,
      'checkoutSessionID': checkoutSessionID,
    };
  }

  // fromDocument
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      paymentStatus: doc['paymentStatus'],
      paymentIntentID: doc['paymentIntentID'],
      checkoutSessionID: doc['checkoutSessionID'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String role;
  // Add additional user-related fields here

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.role,
    // Initialize additional user-related fields here
  });

  void saveToFirestore() {
    FirebaseFirestore.instance.collection('users').doc(id).set({
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'role': role,
      // Add additional user-related fields here
    });
  }

  void updateInFirestore() {
    FirebaseFirestore.instance.collection('users').doc(id).update({
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'role': role,
      // Add additional user-related fields here
    });
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      profilePicture: map['profilePicture'],
      role: map['role'],
      // Add additional user-related fields here
    );
  }
}

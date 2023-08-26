import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _adminCollection =
      FirebaseFirestore.instance.collection('admins');

  Future<String?> userSignup(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _userCollection.doc(userCredential.user!.uid).set({
          'email': email,
          // Add additional user-related fields here
        });

        return userCredential.user!.uid;
      }
    } catch (e) {
      if (kDebugMode) {
        print('User Signup Error: $e');
      }
      return null;
    }
    return null;
  }

  Future<String?> adminSignup(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _adminCollection.doc(userCredential.user!.uid).set({
          'email': email,
          // Add additional admin-related fields here
        });

        return userCredential.user!.uid;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Admin Signup Error: $e');
      }
      return null;
    }
    return null;
  }

  Future<String?> userLogin(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot userSnapshot =
            await _userCollection.doc(userCredential.user!.uid).get();
        if (userSnapshot.exists) {
          return userCredential.user!.uid;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('User Login Error: $e');
      }
      return null;
    }
    return null;
  }

  Future<String?> adminLogin(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot adminSnapshot =
            await _adminCollection.doc(userCredential.user!.uid).get();
        if (adminSnapshot.exists) {
          return userCredential.user!.uid;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Admin Login Error: $e');
      }
      return null;
    }
    return null;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserProfile(
      {required String userId}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _userCollection.doc(userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;
      return userSnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> getUserAttendanceRecords(
      {required String userId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> attendanceSnapshot =
          await _userCollection.doc(userId).collection('attendance').get();
      return attendanceSnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<void> updateUserProfile(
      {required String userId, required String name}) async {
    try {
      await _userCollection.doc(userId).update({'name': name});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

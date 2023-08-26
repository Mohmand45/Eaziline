import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all student records
  Future<QuerySnapshot<Map<String, dynamic>>?> getAllStudentRecords() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> studentRecordsSnapshot =
          await _firestore.collection('users').get();
      return studentRecordsSnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Edit attendance record
  Future<void> editAttendanceRecord(
      {required String attendanceRecordId, required String newStatus}) async {
    try {
      await _firestore
          .collection('attendance')
          .doc(attendanceRecordId)
          .update({'status': newStatus});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // Add attendance record
  Future<void> addAttendanceRecord(
      {required String userId,
      required DateTime date,
      required String status}) async {
    try {
      await _firestore.collection('attendance').add({
        'userId': userId,
        'date': date,
        'status': status,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // Delete attendance record
  Future<void> deleteAttendanceRecord(
      {required String attendanceRecordId}) async {
    try {
      await _firestore
          .collection('attendance')
          .doc(attendanceRecordId)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // Get leave requests
  Future<QuerySnapshot<Map<String, dynamic>>?> getLeaveRequests() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> leaveRequestsSnapshot =
          await _firestore.collection('leaveRequests').get();
      return leaveRequestsSnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Approve or reject leave request
  Future<void> approveRejectLeaveRequest(
      {required String leaveRequestId, required String newStatus}) async {
    try {
      await _firestore
          .collection('leaveRequests')
          .doc(leaveRequestId)
          .update({'status': newStatus});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eaziline/models/attendance_record.dart';
import 'package:eaziline/models/leave_request.dart';
import 'package:flutter/foundation.dart';

class AdminRepository {
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
  Future<List<LeaveRequest>> getLeaveRequests() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> leaveRequestsSnapshot =
          await _firestore.collection('leaveRequests').get();
      final List<LeaveRequest> leaveRequests = leaveRequestsSnapshot.docs
          .map((doc) => LeaveRequest.fromMap(doc.data()))
          .toList();
      return leaveRequests;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
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

  // Generate attendance report for a specific date range
  Future<List<AttendanceRecord>> generateAttendanceReport(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> attendanceSnapshot =
          await _firestore
              .collection('attendance')
              .where('date', isGreaterThanOrEqualTo: startDate)
              .where('date', isLessThanOrEqualTo: endDate)
              .get();
      final List<AttendanceRecord> attendanceRecords = attendanceSnapshot.docs
          .map((doc) => AttendanceRecord.fromMap(doc.data()))
          .toList();
      return attendanceRecords;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  // Get system-wide attendance report for a specific date range
  Future<Map<String, dynamic>> getSystemAttendanceReport(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> attendanceSnapshot =
          await _firestore
              .collection('attendance')
              .where('date', isGreaterThanOrEqualTo: startDate)
              .where('date', isLessThanOrEqualTo: endDate)
              .get();
      final List<AttendanceRecord> attendanceRecords = attendanceSnapshot.docs
          .map((doc) => AttendanceRecord.fromMap(doc.data()))
          .toList();
      int totalPresent = 0;
      int totalAbsent = 0;
      for (final record in attendanceRecords) {
        if (record.status == 'present') {
          totalPresent++;
        } else if (record.status == 'absent') {
          totalAbsent++;
        }
      }
      final Map<String, dynamic> report = {
        'totalPresent': totalPresent,
        'totalAbsent': totalAbsent,
        // Add additional report data as needed
      };
      return report;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return {};
    }
  }
}

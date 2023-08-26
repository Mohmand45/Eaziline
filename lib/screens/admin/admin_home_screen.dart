import 'package:eaziline/screens/admin/attendance_edit_screen.dart';
import 'package:eaziline/screens/admin/create_user_attendance_report_screen.dart';
import 'package:eaziline/screens/admin/student_records_screen.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  void navigateToStudentRecords(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentRecordsScreen()),
    );
  }

  void navigateToAttendanceEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AttendanceEditScreen()),
    );
  }

  void navigateToCreateUserAttendanceReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CreateUserAttendanceReportScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => navigateToStudentRecords(context),
              child: const Text('View Student Records'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => navigateToAttendanceEdit(context),
              child: const Text('Edit Attendance'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => navigateToCreateUserAttendanceReport(context),
              child: const Text('Create User Attendance Report'),
            ),
          ],
        ),
      ),
    );
  }
}

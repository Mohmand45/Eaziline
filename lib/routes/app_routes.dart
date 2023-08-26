import 'package:eaziline/screens/admin/admin_home_screen.dart';
import 'package:eaziline/screens/admin/attendance_edit_screen.dart';
import 'package:eaziline/screens/admin/create_user_attendance_report_screen.dart';
import 'package:eaziline/screens/admin/student_records_screen.dart';
import 'package:eaziline/screens/user/attendance_screen.dart';
import 'package:eaziline/screens/user/home_screen.dart';
import 'package:eaziline/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String attendance = '/attendance';
  static const String profile = '/profile';
  static const String adminHome = '/adminHome';
  static const String studentRecords = '/studentRecords';
  static const String attendanceEdit = '/attendanceEdit';
  static const String createUserAttendanceReport =
      '/createUserAttendanceReport';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case attendance:
        return MaterialPageRoute(
            builder: (_) => const AttendanceScreen(
                  userId: '',
                ));
      case profile:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen(
                  userId: '',
                ));
      case adminHome:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      case studentRecords:
        return MaterialPageRoute(builder: (_) => const StudentRecordsScreen());
      case attendanceEdit:
        return MaterialPageRoute(builder: (_) => const AttendanceEditScreen());
      case createUserAttendanceReport:
        return MaterialPageRoute(
            builder: (_) => const CreateUserAttendanceReportScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Page Not Found'),
                  ),
                ));
    }
  }
}

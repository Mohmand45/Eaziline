import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  final String userId;

  const AttendanceScreen({super.key, required this.userId});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool hasMarkedAttendance = false;

  @override
  void initState() {
    super.initState();
    checkAttendanceStatus();
  }

  void checkAttendanceStatus() async {
    final attendanceSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('attendance')
        .where('date',
            isEqualTo: DateTime.now().toLocal().toString().split(' ')[0])
        .get();

    setState(() {
      hasMarkedAttendance = attendanceSnapshot.docs.isNotEmpty;
    });
  }

  void markAttendance() async {
    final attendanceData = {
      'userId': widget.userId,
      'date': DateTime.now().toLocal().toString().split(' ')[0],
      'status': 'present',
    };

    final userCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('attendance');

    await userCollection.add(attendanceData);

    setState(() {
      hasMarkedAttendance = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Attendance Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              hasMarkedAttendance
                  ? 'Attendance Marked'
                  : 'Attendance Not Marked',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            if (!hasMarkedAttendance)
              ElevatedButton(
                onPressed: markAttendance,
                child: const Text('Mark Attendance'),
              ),
            if (hasMarkedAttendance)
              IgnorePointer(
                ignoring: true,
                child: ElevatedButton(
                  onPressed: null,
                  child: const Text('Mark Attendance'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceEditScreen extends StatefulWidget {
  const AttendanceEditScreen({super.key});

  @override
  _AttendanceEditScreenState createState() => _AttendanceEditScreenState();
}

class _AttendanceEditScreenState extends State<AttendanceEditScreen> {
  late List<DocumentSnapshot> attendanceRecords;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAttendanceRecords();
  }

  Future<void> fetchAttendanceRecords() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('attendance').get();

    setState(() {
      attendanceRecords = snapshot.docs;
      isLoading = false;
    });
  }

  void updateAttendanceStatus(
      DocumentSnapshot<Object?> record, String newStatus) async {
    final attendanceRef =
        FirebaseFirestore.instance.collection('attendance').doc(record.id);

    await attendanceRef.update({'status': newStatus});

    setState(() {
      // Update the status in the local records list as well
      (record.data() as Map<String, dynamic>)['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Edit'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = attendanceRecords[index];

                return ListTile(
                  title: Text(record['userId']),
                  subtitle: Text(record['date']),
                  trailing: DropdownButton<String>(
                    value: record['status'],
                    onChanged: (newStatus) =>
                        updateAttendanceStatus(record, newStatus!),
                    items: ['present', 'absent', 'late']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class CreateUserAttendanceReportScreen extends StatefulWidget {
  const CreateUserAttendanceReportScreen({super.key});

  @override
  _CreateUserAttendanceReportScreenState createState() =>
      _CreateUserAttendanceReportScreenState();
}

class _CreateUserAttendanceReportScreenState
    extends State<CreateUserAttendanceReportScreen> {
  DateTime? startDate;
  DateTime? endDate;

  void generateAttendanceReport() async {
    if (startDate != null && endDate != null) {
      final startDateTimestamp = Timestamp.fromDate(startDate!);
      final endDateTimestamp = Timestamp.fromDate(endDate!);

      final query = FirebaseFirestore.instance
          .collection('attendance')
          .where('date', isGreaterThanOrEqualTo: startDateTimestamp)
          .where('date', isLessThanOrEqualTo: endDateTimestamp);

      query.get().then((querySnapshot) async {
        final attendanceRecords = querySnapshot.docs;
        final pdf = pw.Document();

        // Generate the attendance report using the fetched records
        for (var record in attendanceRecords) {
          final userId = record['userId'];
          final date = record['date'].toDate().toString();

          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Column(
                  children: [
                    pw.Text('User ID: $userId'),
                    pw.Text('Date: $date'),
                    // Add additional fields as needed
                  ],
                );
              },
            ),
          );
        }

        // Save the PDF to a file
        final output = await getTemporaryDirectory();
        final file = File('${output.path}/attendance_report.pdf');
        await file.writeAsBytes(await pdf.save());

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Attendance Report Generated'),
            content: const Text('The attendance report has been generated.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to generate the attendance report.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User Attendance Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select Date Range:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime.now(),
                    );

                    if (selectedDate != null) {
                      setState(() {
                        startDate = selectedDate;
                      });
                    }
                  },
                  child: const Text('Start Date'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime.now(),
                    );

                    if (selectedDate != null) {
                      setState(() {
                        endDate = selectedDate;
                      });
                    }
                  },
                  child: const Text('End Date'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => generateAttendanceReport(),
              child: const Text('Generate Report'),
            ),
          ],
        ),
      ),
    );
  }
}

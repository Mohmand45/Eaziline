import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentRecordsScreen extends StatelessWidget {
  const StudentRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Records'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching student records'),
            );
          }

          final studentRecords = snapshot.data!.docs;

          return ListView.builder(
            itemCount: studentRecords.length,
            itemBuilder: (context, index) {
              final record = studentRecords[index].data();

              return ListTile(
                title: Text(record['name']),
                subtitle: Text(record['email']),
                // Add additional fields as needed
              );
            },
          );
        },
      ),
    );
  }
}

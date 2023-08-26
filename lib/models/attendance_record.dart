class AttendanceRecord {
  final String id;
  final String userId;
  final DateTime date;
  final String status;

  AttendanceRecord({
    required this.id,
    required this.userId,
    required this.date,
    required this.status,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      id: map['id'],
      userId: map['userId'],
      date: map['date'].toDate(),
      status: map['status'],
    );
  }
}

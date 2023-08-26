class LeaveRequest {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status;

  LeaveRequest({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  factory LeaveRequest.fromMap(Map<String, dynamic> map) {
    return LeaveRequest(
      id: map['id'],
      userId: map['userId'],
      startDate: map['startDate'].toDate(),
      endDate: map['endDate'].toDate(),
      reason: map['reason'],
      status: map['status'],
    );
  }
}

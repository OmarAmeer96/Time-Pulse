import 'package:cloud_firestore/cloud_firestore.dart';

class VacationsHistoryModel {
  final String employeeId;
  final String startDate;
  final String endDate;
  final String reason;
  final String requestId;
  final String status;
  final Timestamp createdAt;

  VacationsHistoryModel(
      {required this.employeeId,
      required this.startDate,
      required this.endDate,
      required this.reason,
      required this.requestId,
      required this.status,
      required this.createdAt});
}

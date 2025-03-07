import 'package:cloud_firestore/cloud_firestore.dart';

class VacationsRequestModel {
  final String employeeId;
  final String employeeName;
  final String startDate;
  final String endDate;
  final String reason;
  final String requestId;
  String status;
  final Timestamp createdAt;

  VacationsRequestModel({
    required this.employeeId,
    required this.employeeName,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.requestId,
    required this.status,
    required this.createdAt,
  });
}

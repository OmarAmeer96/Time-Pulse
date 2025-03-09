import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String name;
  final String email;
  final String id;
  final int remaining_leaves;
  bool isCheckedIn = false;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.id,
    required this.remaining_leaves,
  });

  factory EmployeeModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return EmployeeModel(
        name: data?['name'] ?? '',
        email: data?['email'] ?? "",
        id: data?['ID'].toString() ?? "",
        remaining_leaves: data?['remaining_leaves'] ?? 0);
  }

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "ID": id,
      "email": email,
      "remaining_leaves": remaining_leaves,
      "is_checked_in": isCheckedIn,
    };
  }
}

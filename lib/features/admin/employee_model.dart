import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String name;
  final String email;
  final String password;
  final String id;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
  });

  factory EmployeeModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return EmployeeModel(
      name: data?['name'] ?? '',
      email: data?['email'] ?? "",
      password: data?['password'] ?? '',
      id: data?['ID'].toString() ?? "",
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "ID": id,
      "email": email,
      "password": password,
    };
  }
}

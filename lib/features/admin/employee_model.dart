class EmployeeModel {
  final String name;
  final String email;
  final String password;
  final int id;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "ID": id,
      "email": email,
      "password": password,
    };
  }
}

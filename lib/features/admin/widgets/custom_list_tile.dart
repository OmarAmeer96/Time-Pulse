import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.employeeName, required this.employeeId});

  final String employeeName;
  final String employeeId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(employeeName),
      subtitle: Text(employeeId),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}

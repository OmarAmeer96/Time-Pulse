import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, required this.employeeName, required this.employeeId});

  final String employeeName;
  final String employeeId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 70,
        child: ListTile(
          leading: Icon(Icons.person, color: Colors.white),
          title: Text(employeeName, style: TextStyle(color: Colors.white, fontSize: 16)),
          subtitle: Text(employeeId, style: TextStyle(color: Colors.white, fontSize: 10)),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

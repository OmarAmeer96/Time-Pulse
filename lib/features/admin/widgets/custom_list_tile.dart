import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/data/extensions/extensions.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.employeeName,
      required this.employeeId,
      required this.onTap});

  final String employeeName;
  final String employeeId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: MyTheme.primaryColor),
          // color: MyTheme.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 70,
        child: ListTile(
          leading: Icon(Icons.person, color: MyTheme.primaryColor, size: 30),
          title: Text(employeeName,
              style: TextStyle(color: MyTheme.primaryColor, fontSize: 20)),
          subtitle: Text(employeeId,
              style: TextStyle(color: MyTheme.primaryColor, fontSize: 10)),
          trailing: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: MyTheme.primaryColor,
            ),
          ),
        ),
      ).decorate(padding: 4) ,
    );
  }
}

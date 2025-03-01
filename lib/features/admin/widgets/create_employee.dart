import 'package:flutter/material.dart';
import 'package:time_pulse/features/admin/widgets/custom_button.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'Add Employee',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff80c6c5)
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Name',
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'ID',
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Email',
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Password',
            ),
            SizedBox(height: 20),
            CustomButton()
          ],
        ),
      ),
    );
  }
}

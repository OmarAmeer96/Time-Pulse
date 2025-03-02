import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_pulse/features/admin/employee_model.dart';
import 'package:time_pulse/features/admin/widgets/custom_button.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  late final TextEditingController nameController;
  late final TextEditingController idController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    idController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  color: Color(0xff80c6c5)),
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              hintText: 'Name',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: idController,
              hintText: 'ID',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                EmployeeModel employee = EmployeeModel(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  id: idController.text,
                );
                db.collection("employees").add(employee.toFireStore());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Account Created Successfully'),
                  // backgroundColor: Theme.of(context).colorScheme.error,
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

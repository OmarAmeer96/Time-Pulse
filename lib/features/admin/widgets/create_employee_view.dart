import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;

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
                color: Color(0xff80c6c5),
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              hintText: 'Name',
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
              onPressed: () async {
                try {
                  final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  final User? user = userCredential.user; // Get the user from the UserCredential

                  if (user != null) {
                    EmployeeModel employee = EmployeeModel(
                      name: nameController.text,
                      email: emailController.text,
                      id: user.uid,
                    );
                    db.collection("employees").add(employee.toFireStore());
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Account Created Successfully'),
                    ));
                  } else {
                    // Handle the case where user is null
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('User creation failed. Please try again.'),
                    ));
                  }
                } catch (e) {
                  // Handle any errors that occur during user creation
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: ${e.toString()}'),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

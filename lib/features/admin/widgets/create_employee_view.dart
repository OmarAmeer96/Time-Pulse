import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/core/widgets/custom_text_form_field.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_cubit.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_button.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
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
                    color: MyTheme.primaryColor,
                  ),
                ),
                CustomTextFormField(
                  controller: nameController,
                  label: 'Name',
                  validate: validateName,
                  prefixIcon: Icon(Icons.person),
                ),
                CustomTextFormField(
                  controller: emailController,
                  label: 'Email',
                  validate: validateEmail,
                  prefixIcon: Icon(Icons.email),
                ),
                CustomTextFormField(
                  controller: passwordController,
                  label: 'Password',
                  validate: validatePassword,
                  prefixIcon: Icon(Icons.lock),
                ),
                CustomButton(
                  onPressed: () async {
                    try {
                      context.read<AdminCubit>().addEmployee(
                            nameController,
                            emailController,
                            passwordController,
                          );
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'Account Created Successfully',
                      );
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter employee name';
    }
    bool nameValid = RegExp(r"^[a-zA-Z]+").hasMatch(value);
    if (!nameValid) {
      return 'Please enter valid employee name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please, enter your email';
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Email is not valid ,please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please,enter your password';
    } else if (value!.length < 6) {
      return 'Password must be at least 6 chars';
    }
    return null;
  }
}

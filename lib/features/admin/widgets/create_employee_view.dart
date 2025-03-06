import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit.dart';
import 'package:time_pulse/features/admin/cubit/admin_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_button.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';

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
                      context.read<AdminCubit>().addEmployee(
                            nameController,
                            emailController,
                            passwordController,
                          );
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: 'Account Created Successfully');
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text('Account Created Successfully'),
                      // ));
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text('Error: ${e.toString()}'),
                      // ));
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
}

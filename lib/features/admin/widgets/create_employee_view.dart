import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/core/widgets/custom_text_form_field.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_cubit.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_button.dart';
import 'package:time_pulse/generated/l10n.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).add_employee,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.primaryColor,
                    ),
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    label: S.of(context).name,
                    validate: validateName,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    label: S.of(context).email,
                    validate: validateEmail,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    label: S.of(context).password,
                    validate: validatePassword,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await context.read<AdminCubit>().addEmployee(
                                nameController,
                                emailController,
                                passwordController,
                              );
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: S.of(context).account_created,
                          );
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: 'Error: ${e.toString()}',
                          );
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ).decorate(padding: 4, context: context);
      },
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).enter_employee_name;
    }
    bool nameValid = RegExp(r"^[a-zA-Z]+").hasMatch(value);
    if (!nameValid) {
      return S.of(context).valid_name;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).enter_your_email;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return S.of(context).valid_email;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).enter_your_password;
    } else if (value.length < 6) {
      return S.of(context).password_length;
    }
    return null;
  }
}

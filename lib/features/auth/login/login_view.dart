import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/constants.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/core/widgets/custom_button.dart';
import 'package:time_pulse/core/widgets/custom_text_form_field.dart';
import 'package:time_pulse/core/widgets/global_loading_dialog.dart';
import 'package:time_pulse/features/auth/cubit/auth_cubit.dart';
import 'package:time_pulse/features/auth/widgets/custom_container.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';

import '../../../generated/l10n.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool obscure = true;
  Color userColor = MyTheme.primaryColor;
  Color adminColor = Colors.transparent;
  bool isAdmin = false;

  @override
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.read<ThemeCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          GlobalDialog.showLoadingDialog(context);
        } else if (state is AuthAuthenticated) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
              context, isAdmin ? Routes.adminHomeView : Routes.mainView);
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: theme.darkMode
                        ? MyTheme.greyColor
                        : Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainer(
                      text: S.of(context).user,
                      containerColor: userColor,
                      onTap: () {
                        isAdmin = false;
                        userColor = MyTheme.primaryColor;
                        adminColor = Colors.transparent;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CustomContainer(
                      text: S.of(context).admin,
                      containerColor: adminColor,
                      onTap: () {
                        isAdmin = true;
                        adminColor = MyTheme.primaryColor;
                        userColor = Colors.transparent;

                        setState(() {});
                      },
                    )
                  ],
                ),
              ),
              CustomTextFormField(
                controller: emailController,
                validate: validateEmail,
                label: S.of(context).email,
                prefixIcon: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                  controller: passwordController,
                  validate: validatePassword,
                  label: S.of(context).password,
                  prefixIcon: Icon(Icons.lock),
                  keyboardType: TextInputType.number,
                  obsure: obscure,
                  suffixIcon: obscure
                      ? IconButton(
                          onPressed: () {
                            obscure = false;
                            setState(() {});
                          },
                          icon: Icon(Icons.visibility_off),
                        )
                      : IconButton(
                          onPressed: () {
                            obscure = true;
                            setState(() {});
                          },
                          icon: Icon(Icons.visibility_outlined),
                        )),
              TextButton(
                onPressed: restPassword,
                child: Row(children: [
                  Text(
                    S.of(context).forget_password,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.start,
                  )
                ]),
              ),
              CustomButton(
                icon: const Icon(Icons.login, color: Colors.white),
                text: S.of(context).login,
                onPressed: login,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
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
    if (value?.isEmpty ?? true) {
      return 'Please,enter your password';
    } else if (value!.length < 6) {
      return 'Password must be at least 6 chars';
    }
    return null;
  }

  final List<String> adminEmails = [
    'hr@gmail.com',
  ];

  login() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim().toLowerCase();

      if (adminEmails.contains(email) && !isAdmin) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).admin_must_use_admin_tab)),
        );
        return;
      }

      if (!adminEmails.contains(email) && isAdmin) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).user_must_use_user_tab)),
        );
        return;
      }

      context.read<AuthCubit>().login(email, passwordController.text, context);

      await SharedPrefHelper.setData("isAdmin", isAdmin);
      await SharedPrefHelper.setData("isUserLoggedIn", true);
      isUserLoggedIn = true;
    }
  }

  restPassword() {
    context.read<AuthCubit>().resetPassword(emailController.text, context);
  }
}

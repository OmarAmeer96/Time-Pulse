import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/core/widgets/custom_button.dart';
import 'package:time_pulse/features/auth/widgets/custom_container.dart';
import 'package:time_pulse/core/widgets/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final _auth = FirebaseAuth.instance;
  bool obsure = true;
  Color userColor = MyTheme.primaryColor;
  Color adminColor = Colors.transparent;
  bool isAdmin = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Colors.grey.shade300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    text: 'User',
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
                    text: 'Admin',
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
              label: "Email",
              prefixIcon: Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
                controller: passwordController,
                validate: validatePassword,
                label: "Password",
                prefixIcon: Icon(Icons.lock),
                keyboardType: TextInputType.number,
                obsure: obsure,
                suffixIcon: obsure
                    ? IconButton(
                        onPressed: () {
                          obsure = false;
                          setState(() {});
                        },
                        icon: Icon(Icons.visibility_off),
                      )
                    : IconButton(
                        onPressed: () {
                          obsure = true;
                          setState(() {});
                        },
                        icon: Icon(Icons.visibility_outlined),
                      )),
            TextButton(
              onPressed: resetPassword,
              child: Row(children: [
                Text(
                  'Forget Password !',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.start,
                )
              ]),
            ),
            CustomButton(
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              text: 'Login',
              onPressed: login,
            ),
          ],
        ),
      ),
    );
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

  login() async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          SharedPrefHelper.setData("employeeId", value.user!.uid);
          SharedPrefHelper.setData("employeeEmail", value.user!.email);
        });

        Navigator.pushReplacementNamed(
            context, isAdmin ? Routes.adminView : Routes.mainView);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'The supplied auth credential is incorrect, malformed or has expired.',
                  style: TextStyle(
                    color: MyTheme.redColor,
                  ))));

          debugPrint(
              'The supplied auth credential is incorrect, malformed or has expired.');
        } else {
          debugPrint(e.toString());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }
  }

  void resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else {
        errorMessage = e.message ?? 'An error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthLoading());

  login(String email, String password, BuildContext context) async {
    try {
      emit(AuthLoading());
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SharedPrefHelper.setData("employeeId", value.user!.uid);
        SharedPrefHelper.setData("employeeEmail", value.user!.email);
        emit(AuthAuthenticated());
      });
    } on FirebaseAuthException catch (e) {
      emit(AuthUnauthenticated());
      if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(
            msg:
                "The supplied auth credential is incorrect, malformed or has expired.");
        debugPrint(
            'The supplied auth credential is incorrect, malformed or has expired.');
      } else {
        debugPrint(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "'Password reset email sent!'");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else {
        errorMessage = e.message ?? 'An error occurred.';
      }
      Fluttertoast.showToast(msg: errorMessage);
    }
  }
}

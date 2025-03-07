import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/features/admin/models/employee_model.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminPageInitial());
  List<EmployeeModel> employees = [];
  var db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getEmployeeData() async {
    emit(AdminPageLoading());
    try {
      await db.collection('employees').get().then((event) {
        for (var doc in event.docs) {
          employees.add(EmployeeModel.fromFireStore(doc));
        }
      });
      emit(AdminPageLoaded());
    } catch (e) {
      emit(AdminPageError());
    }
  }

  addEmployee(
      final TextEditingController nameController,
      final TextEditingController emailController,
      final TextEditingController passwordController) async {
    try {
      emit(AdminPageLoading());
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        EmployeeModel employee = EmployeeModel(
          name: nameController.text,
          email: emailController.text,
          id: user.uid,
        );
        db.collection("employees").add(employee.toFireStore());
        employees.add(employee);
        emit(EmployeeAdded());
      }
    } catch (e) {
      emit(AdminPageError());
    }
  }
}

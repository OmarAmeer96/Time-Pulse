import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/data/models/employee_model.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminPageInitial());
  List<EmployeeModel> employees = [];
  List<EmployeeModel> filteredEmployees = [];
  String employeeGender = "Male";

  var db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getEmployeeData() async {
    emit(AdminPageLoading());
    try {
      employees.clear();
      var snapshot = await db.collection('employees').get();
      for (var doc in snapshot.docs) {
        employees.add(EmployeeModel.fromFireStore(doc));
      }
      filteredEmployees = List.from(employees);
      emit(AdminPageLoaded());
    } catch (e) {
      emit(AdminPageError());
    }
  }

  void filterEmployees(String query) {
    if (query.isEmpty) {
      filteredEmployees = List.from(employees);
    } else {
      filteredEmployees = employees.where((employee) {
        return employee.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(AdminPageLoaded());
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
            remaining_leaves: 21,
            role: "user",
            isCheckedIn: false,
            imageUrl: employeeGender == "Male"
                ? "https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=BpR0FVaEa5F24GIw7K8nMWiiGmbb8qmhfkpXcp1dhQg="
                : "https://media.istockphoto.com/id/1074273082/vector/person-gray-photo-placeholder-woman.jpg?s=612x612&w=0&k=20&c=XhXXk0uHEK0aZA9AgzGhbYPqmWz3Qk2reH9nZ6BO2sM=");
        db.collection("employees").add(employee.toFireStore()).then((value) {
          employees.add(employee);
          emit(EmployeeAdded());
        }).then((value) {
          getEmployeeData();
        });
      }
    } catch (e) {
      emit(AdminPageError());
    }
  }

  selectEmployeeGender(String type) {
    employeeGender = type;
    emit(EmployeeGenderSelected());
  }

  logout() async {
    await auth.signOut();
  }
}

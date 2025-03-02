import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_pulse/features/admin/employee_model.dart';

class EmployeeService {
  var db = FirebaseFirestore.instance;

  Future<List<EmployeeModel>> getEmployeeData() async {
    List<EmployeeModel> employees = [];
    await db.collection('employees').get().then((event) {
      for (var doc in event.docs) {
        employees.add(EmployeeModel.fromFireStore(doc)) ;
      }
    });
    return employees;
  }
}
//  Future<UserProfile> getUserData() async {
//     String email = await SharedPrefHelper.getString('email');
//     late UserProfile user;
//     await db.collection('users').get().then((event) {
//       for (var doc in event.docs) {
//         if (UserProfile.fromFireStore(doc).email == email) {
//           user = UserProfile.fromFireStore(doc);
//         }
//       }
//     });
//     return user;
//   }

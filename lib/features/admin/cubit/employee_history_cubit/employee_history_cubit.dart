import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/data/models/user_history_model.dart';
import 'package:time_pulse/features/admin/cubit/employee_history_cubit/employee_history_state.dart';

class EmployeeHistoryCubit extends Cubit<EmployeeHistoryState> {
  late List<UserHistoryModel> employeeHistory = [];
  EmployeeHistoryCubit() : super(EmployeeHistoryInitial());

  getHistory() async {
    emit(EmployeeHistoryLoading());
    String id = await SharedPrefHelper.getString("employeeHistoryId");
    final db = FirebaseFirestore.instance;
    db
        .collection("checkInAndOutTimes")
        .orderBy('createdAt', descending: true)
        .where("employeeId", isEqualTo: id)
        .get()
        .then(
      (querySnapshot) {
        debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
          employeeHistory.add(
            UserHistoryModel(
              checkInTime: docSnapshot.data()['checkIn'],
              checkOutTime: docSnapshot.data()['checkOut'],
              email: docSnapshot.data()['email'],
              employeeId: docSnapshot.data()['employeeId'],
            ),
          );
        }
        if (employeeHistory.isEmpty) {
          emit(EmployeeEmptyHistory());
        } else {
          emit(EmployeeHistoryLoaded());
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}

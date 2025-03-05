import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/data/models/vacations_history_model.dart';
part 'vacations_history_state.dart';

class VacationsHistoryCubit extends Cubit<VacationsHistoryState> {
  VacationsHistoryCubit() : super(VacationsHistoryInitial());
  late List<VacationsHistoryModel> vacationsHistory = [];
  getVacationsHistory() async {
    emit(VacationsHistoryLoading());
    String id = await SharedPrefHelper.getString("employeeId");
    final db = FirebaseFirestore.instance;
    db
        .collection("vacationRequests")
        .orderBy('createdAt', descending: true)
        .where("employeeId", isEqualTo: id)
        .get()
        .then(
      (querySnapshot) {
        debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
          vacationsHistory.add(VacationsHistoryModel(
            employeeId: docSnapshot.data()['employeeId'],
            requestId: docSnapshot.data()['requestId'],
            startDate: docSnapshot.data()['startDate'],
            endDate: docSnapshot.data()['endDate'],
            reason: docSnapshot.data()['reason'],
            status: docSnapshot.data()['status'],
            createdAt: docSnapshot.data()['createdAt'],
          ));
        }

        if (vacationsHistory.isEmpty) {
          emit(EmptyVacationsHistory());
        } else {
          emit(VacationsHistoryLoaded());
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}

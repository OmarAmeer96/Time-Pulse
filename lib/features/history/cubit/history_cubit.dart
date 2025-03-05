import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/data/models/user_history_model.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  late List<UserHistoryModel> userHistory = [];
  HistoryCubit() : super(HistoryInitial());

  getHistory() async {
    emit(HistoryLoading());
    String id = await SharedPrefHelper.getString("employeeId");
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
          userHistory.add(UserHistoryModel(
              checkInTime: docSnapshot.data()['checkIn'],
              checkOutTime: docSnapshot.data()['checkOut'],
              email: docSnapshot.data()['email'],
              employeeId: docSnapshot.data()['employeeId']));
        }
        if (userHistory.isEmpty) {
          emit(EmptyHistory());
        } else {
          emit(HistoryLoaded());
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}

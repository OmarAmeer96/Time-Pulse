import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/features/admin/models/vacation_request_model.dart';

class VacationsCubit extends Cubit<VacationsState> {
  VacationsCubit() : super(VacationsInitial());
  late List<VacationsRequestModel> vacations = [];
  late List<VacationsRequestModel> pendingVacations = [];
  late List<VacationsRequestModel> acceptedVacations = [];
  late List<VacationsRequestModel> rejectedVacations = [];
  getVacations() async {
    emit(VacationsLoading());
    final db = FirebaseFirestore.instance;
    db
        .collection("vacationRequests")
        .orderBy('createdAt', descending: true)
        .get()
        .then(
      (querySnapshot) {
        debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          vacations.add(
            VacationsRequestModel(
              employeeId: docSnapshot.data()['employeeId'],
              employeeName: docSnapshot.data()['employeeName'],
              requestId: docSnapshot.data()['requestId'],
              startDate: docSnapshot.data()['startDate'],
              endDate: docSnapshot.data()['endDate'],
              reason: docSnapshot.data()['reason'],
              status: docSnapshot.data()['status'],
              createdAt: docSnapshot.data()['createdAt'],
            ),
          );
          if (docSnapshot.data()['status'] == "Pending") {
            pendingVacations.add(
              VacationsRequestModel(
                employeeId: docSnapshot.data()['employeeId'],
                employeeName: docSnapshot.data()['employeeName'],
                requestId: docSnapshot.data()['requestId'],
                startDate: docSnapshot.data()['startDate'],
                endDate: docSnapshot.data()['endDate'],
                reason: docSnapshot.data()['reason'],
                status: docSnapshot.data()['status'],
                createdAt: docSnapshot.data()['createdAt'],
              ),
            );
            emit(PendingVacations());
          } else if (docSnapshot.data()['status'] == "Accepted") {
            acceptedVacations.add(
              VacationsRequestModel(
                employeeId: docSnapshot.data()['employeeId'],
                employeeName: docSnapshot.data()['employeeName'],
                requestId: docSnapshot.data()['requestId'],
                startDate: docSnapshot.data()['startDate'],
                endDate: docSnapshot.data()['endDate'],
                reason: docSnapshot.data()['reason'],
                status: docSnapshot.data()['status'],
                createdAt: docSnapshot.data()['createdAt'],
              ),
            );
            emit(AcceptedVacations());
          } else if (docSnapshot.data()['status'] == "Rejected") {
            rejectedVacations.add(
              VacationsRequestModel(
                employeeId: docSnapshot.data()['employeeId'],
                employeeName: docSnapshot.data()['employeeName'],
                requestId: docSnapshot.data()['requestId'],
                startDate: docSnapshot.data()['startDate'],
                endDate: docSnapshot.data()['endDate'],
                reason: docSnapshot.data()['reason'],
                status: docSnapshot.data()['status'],
                createdAt: docSnapshot.data()['createdAt'],
              ),
            );
            emit(RejectedVacations());
          }
        }

        if (vacations.isEmpty) {
          emit(EmptyVacations());
        } else {
          emit(VacationsLoaded());
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/data/models/vacation_request_model.dart';

class VacationsCubit extends Cubit<VacationsState> {
  VacationsCubit() : super(VacationsInitial());

  List<VacationsRequestModel> vacations = [];
  List<VacationsRequestModel> pendingVacations = [];
  List<VacationsRequestModel> acceptedVacations = [];
  List<VacationsRequestModel> rejectedVacations = [];

  getVacations() async {
    emit(VacationsLoading());
    final db = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await db
          .collection("vacationRequests")
          .orderBy('createdAt', descending: true)
          .get();

      vacations.clear();
      for (var docSnapshot in querySnapshot.docs) {
        vacations.add(
          VacationsRequestModel(
            employeeId:
                (docSnapshot.data() as Map<String, dynamic>)['employeeId'] ??
                    '',
            employeeName:
                (docSnapshot.data() as Map<String, dynamic>)['employeeName'] ??
                    '',
            requestId:
                (docSnapshot.data() as Map<String, dynamic>)['requestId'] ?? '',
            startDate:
                (docSnapshot.data() as Map<String, dynamic>)['startDate'] ?? '',
            endDate:
                (docSnapshot.data() as Map<String, dynamic>)['endDate'] ?? '',
            reason:
                (docSnapshot.data() as Map<String, dynamic>)['reason'] ?? '',
            status:
                (docSnapshot.data() as Map<String, dynamic>)['status'] ?? '',
            createdAt:
                (docSnapshot.data() as Map<String, dynamic>)['createdAt'] ?? '',
          ),
        );
      }

      getPendingVacations();
      getAcceptedVacations();
      getRejectedVacations();

      if (vacations.isEmpty) {
        emit(EmptyVacations());
      } else {
        emit(VacationsLoaded());
      }
    } catch (e) {
      debugPrint("Error fetching vacations: $e");
      emit(VacationsError(e.toString()));
    }
  }

  getPendingVacations() {
    pendingVacations.clear();
    for (var vacation in vacations) {
      if (vacation.status == "Pending") {
        pendingVacations.add(vacation);
      }
    }
  }

  getAcceptedVacations() {
    acceptedVacations.clear();
    for (var vacation in vacations) {
      if (vacation.status == "Accepted") {
        acceptedVacations.add(vacation);
      }
    }
  }

  getRejectedVacations() {
    rejectedVacations.clear();
    for (var vacation in vacations) {
      if (vacation.status == "Rejected") {
        rejectedVacations.add(vacation);
      }
    }
  }
}

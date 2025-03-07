import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
part 'vacation_request_state.dart';

class VacationRequestCubit extends Cubit<VacationRequestState> {
  TextEditingController startDateController = TextEditingController();
  DateTime? selectedStartDate;
  TextEditingController endDateController = TextEditingController();
  DateTime? selectedEndDate;
  TextEditingController reasonController = TextEditingController();
  GlobalKey<FormState> vacationRequestFormKey = GlobalKey();
  late int remainingLeaves;
  VacationRequestCubit() : super(VacationRequestInitial());

  addVacationRequestToFirebase() async {
    emit(VacationRequestLoading());
    final db = FirebaseFirestore.instance;
    String id = await SharedPrefHelper.getString("employeeId");
    String employeeName = await SharedPrefHelper.getString("employeeName");

    final data = {
      "requestId": "",
      "employeeId": id,
      "startDate": startDateController.text,
      "endDate": endDateController.text,
      "reason": reasonController.text,
      "status": "Pending",
      "employeeName": employeeName,
      'createdAt': FieldValue.serverTimestamp()
    };

    await db
        .collection("vacationRequests")
        .add(data)
        .then((documentSnapshot) async {
      await documentSnapshot.update({"requestId": documentSnapshot.id});
    }).then((value) {
      emit(VacationRequestLoaded());
    });
  }

  selectStartDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (selectedEndDate != null) {
        if (pickedDate.isAfter(selectedEndDate!)) {
          Fluttertoast.showToast(msg: "You should select a correct start date");
        } else {
          selectedStartDate = pickedDate;
          String formattedDateTime =
              DateFormat('yyyy-MM-dd').format(pickedDate);

          startDateController.text = formattedDateTime;
        }
      } else {
        selectedStartDate = pickedDate;
        String formattedDateTime = DateFormat('yyyy-MM-dd').format(pickedDate);

        startDateController.text = formattedDateTime;
      }
    }
  }

  selectEndDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (selectedStartDate != null) {
        if (pickedDate.isBefore(selectedStartDate!)) {
          Fluttertoast.showToast(msg: "You should select a correct end date");
        } else {
          selectedEndDate = pickedDate;
          String formattedDateTime =
              DateFormat('yyyy-MM-dd').format(pickedDate);

          endDateController.text = formattedDateTime;
        }
      } else {
        selectedEndDate = pickedDate;
        String formattedDateTime = DateFormat('yyyy-MM-dd').format(pickedDate);

        endDateController.text = formattedDateTime;
      }
    }
  }

  submitVacationRequest() async {
    int totalVacationDays =
        selectedEndDate!.difference(selectedStartDate!).inDays;
    if (remainingLeaves > 0 && totalVacationDays <= remainingLeaves) {
      await addVacationRequestToFirebase();
    } else {
      emit(VacationRequestUnavailable());
    }
    startDateController.clear();
    endDateController.clear();
    reasonController.clear();

    selectedStartDate = null;
    selectedEndDate = null;
  }

  getUserRemainingleaves() async {
    String id = await SharedPrefHelper.getString("employeeId");
    final db = FirebaseFirestore.instance;
    db.collection("employees").where("ID", isEqualTo: id).get().then(
      (querySnapshot) async {
        debugPrint("Successfully completed");
        remainingLeaves = querySnapshot.docs[0].data()['remaining_leaves'];
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}

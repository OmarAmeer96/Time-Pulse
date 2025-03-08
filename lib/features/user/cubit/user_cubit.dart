import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late double employeeLatitude;
  late double employeeLongitude;
  bool isCheckedIn = false;
  bool inCompanyArea = false;
  late String checkInTime;
  late String checkOutTime;
  late String docId;
  String employeeName = '';
  late int employeeRemainingLeaves;
  UserCubit() : super(UserInitial());

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position employeePosition = await Geolocator.getCurrentPosition();
    employeeLatitude = employeePosition.latitude;
    employeeLongitude = employeePosition.longitude;

    return await Geolocator.getCurrentPosition();
  }

  checkInAndOut() async {
    emit(UserLocationLoading(employeeName: employeeName));
    await determinePosition();
    double companyLatitude = employeeLatitude;
    double companyLongitude = employeeLongitude;
    double distance = Geolocator.distanceBetween(
        employeeLatitude, employeeLongitude, companyLatitude, companyLongitude);
    emit(UserLocationLoaded(employeeName: employeeName));

    if (distance <= 100 && isCheckedIn == false) {
      await addCheckInAndOutTimeToFirebase();
      isCheckedIn = true;
      // await SharedPrefHelper.setData("isCheckedIn", true);
      await updateUserCase(true);
      inCompanyArea = true;

      debugPrint("Check innnnnnnnnnnnnnnnn");
      emit(UserCheckedIn(employeeName: employeeName));
    } else if (distance <= 100 && isCheckedIn) {
      await addCheckInAndOutTimeToFirebase();
      isCheckedIn = false;
      // await SharedPrefHelper.setData("isCheckedIn", false);
      await updateUserCase(false);
      inCompanyArea = true;

      debugPrint("check outtttttttttttttttttttt");
      emit(UserCheckedOut(employeeName: employeeName));
    } else {
      inCompanyArea = false;
      emit(UserNotInCompanyArea(employeeName: employeeName));
      debugPrint("Out of areaaaaaaaaaaaaa");
    }
  }

  getTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now);
    if (isCheckedIn) {
      checkOutTime = formattedDate;
      debugPrint("Outttttttttttttttttttttttttt");
      debugPrint(checkOutTime);
    } else {
      checkInTime = formattedDate;
      debugPrint("Innnnnnnnnnnnnnnnnnnnnnnnnnn");
      debugPrint(checkInTime);
    }
  }

  addCheckInAndOutTimeToFirebase() async {
    final db = FirebaseFirestore.instance;
    // isCheckedIn = await SharedPrefHelper.getBool("isCheckedIn");
    String id = await SharedPrefHelper.getString("employeeId");
    if (isCheckedIn) {
      db.collection("employees").where("ID", isEqualTo: id).get().then(
        (querySnapshot) async {
          debugPrint("Successfully completed");
          docId = querySnapshot.docs[0].data()['last_check_id'];
        },
        onError: (e) => debugPrint("Error completing: $e"),
      ).then((value) {
        final emplyeeData = db.collection("checkInAndOutTimes").doc(docId);
        emplyeeData.update({"checkOut": checkOutTime}).then(
            (value) => debugPrint("DocumentSnapshot successfully updated!"),
            onError: (e) => debugPrint("Error updating document $e"));
      });
    } else if (!isCheckedIn) {
      String id = await SharedPrefHelper.getString("employeeId");
      String email = await SharedPrefHelper.getString("employeeEmail");

      final data = {
        "employeeId": id,
        "email": email,
        "checkIn": checkInTime,
        "checkOut": "",
        'createdAt': FieldValue.serverTimestamp()
      };

      await db
          .collection("checkInAndOutTimes")
          .add(data)
          .then((documentSnapshot) {
        docId = documentSnapshot.id;
        db
            .collection("employees")
            .where("ID", isEqualTo: id)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs[0].reference.update({'last_check_id': docId}).then(
            (value) => debugPrint("Document successfully updated!"),
            onError: (e) => debugPrint("Error updating document: $e"),
          );
        });
        // SharedPrefHelper.setData("docId", docId);
        debugPrint("Added Data with ID: ${documentSnapshot.id}");
      });
    }
  }

  getEmployeeData() async {
    String id = await SharedPrefHelper.getString("employeeId");
    // isCheckedIn = await SharedPrefHelper.getBool("isCheckedIn");
    // docId = await SharedPrefHelper.getString("docId");
    final db = FirebaseFirestore.instance;
    db.collection("employees").where("ID", isEqualTo: id).get().then(
      (querySnapshot) async {
        debugPrint("Successfully completed");
        employeeName = querySnapshot.docs[0].data()['name'];
        await SharedPrefHelper.setData("employeeName", employeeName);
        isCheckedIn = querySnapshot.docs[0].data()['is_checked_in'];
        employeeRemainingLeaves =
            querySnapshot.docs[0].data()['remaining_leaves'];
        await SharedPrefHelper.setData(
            "employeeRemainingLeaves", employeeRemainingLeaves);
        emit(UserInitial(employeeName: employeeName));
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  updateUserCase(checkedIn) async {
    final db = FirebaseFirestore.instance;
    String id = await SharedPrefHelper.getString("employeeId");
    db
        .collection("employees")
        .where("ID", isEqualTo: id)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs[0].reference.update({'is_checked_in': checkedIn}).then(
        (value) => debugPrint("Document successfully updated!"),
        onError: (e) => debugPrint("Error updating document: $e"),
      );
    });
  }
}

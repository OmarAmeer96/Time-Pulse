import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/admin/cubit/admin_state.dart';
import 'package:time_pulse/features/admin/employee_model.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminPageInitial());
  List<EmployeeModel> employees = [];
  var db = FirebaseFirestore.instance;
  getEmployeeData() async {
    emit(AdminPageLoading());
    try {
      await db.collection('employees').get().then((event) {
        for (var doc in event.docs) {
          employees.add(EmployeeModel.fromFireStore(doc));
        }
      });
      emit(AdminPageLoaded());
    } on Exception catch (e) {
      emit(AdminPageError(e.toString()));
    }
  }
}

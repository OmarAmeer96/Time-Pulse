import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_cubit.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/features/admin/models/vacation_request_model.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_request_card.dart';
import 'package:time_pulse/generated/l10n.dart';

class AdminVrv extends StatefulWidget {
  const AdminVrv({Key? key}) : super(key: key);

  @override
  State<AdminVrv> createState() => _AdminVrvState();
}

class _AdminVrvState extends State<AdminVrv> {
  String pageStatus = 'Pending';
  final Set<String> acceptLoading = {};
  final Set<String> rejectLoading = {};

  @override
  void initState() {
    super.initState();
    final cubit = context.read<VacationsCubit>();
    cubit.vacations.clear();
    cubit.pendingVacations.clear();
    cubit.acceptedVacations.clear();
    cubit.rejectedVacations.clear();
    cubit.getVacations();
    cubit.getPendingVacations();
    cubit.getAcceptedVacations();
    cubit.getRejectedVacations();
  }

  Future<void> _onAccept(VacationsRequestModel vacation) async {
    setState(() {
      acceptLoading.add(vacation.requestId);
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('employees')
          .where('ID', isEqualTo: vacation.employeeId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("Employee not found");
      }

      DocumentSnapshot employeeDoc = querySnapshot.docs.first;
      Map<String, dynamic> employeeData =
          employeeDoc.data() as Map<String, dynamic>;

      DateTime startDate = DateTime.parse(vacation.startDate);
      DateTime endDate = DateTime.parse(vacation.endDate);
      int leaveDays = endDate.difference(startDate).inDays + 1;

      int remainingLeaves =
          (employeeData['remaining_leaves'] ?? 21) - leaveDays;
      if (remainingLeaves < 0) {
        throw Exception("Not enough leave balance");
      }

      await FirebaseFirestore.instance
          .collection('employees')
          .doc(employeeDoc.id)
          .update({
        'remaining_leaves': remainingLeaves,
      });

      await FirebaseFirestore.instance
          .collection("vacationRequests")
          .doc(vacation.requestId)
          .update({"status": "Accepted"});

      setState(() {
        vacation.status = "Accepted";
        acceptLoading.remove(vacation.requestId);
      });

      final cubit = context.read<VacationsCubit>();
      cubit.getVacations();
      cubit.getAcceptedVacations();
      cubit.getPendingVacations();
    } catch (e) {
      setState(() {
        acceptLoading.remove(vacation.requestId);
      });
      debugPrint("Error updating status to Accepted: $e");
    }
  }

  Future<void> _onReject(VacationsRequestModel vacation) async {
    setState(() {
      rejectLoading.add(vacation.requestId);
    });
    try {
      await FirebaseFirestore.instance
          .collection("vacationRequests")
          .doc(vacation.requestId)
          .update({"status": "Rejected"});

      setState(() {
        vacation.status = "Rejected";
        rejectLoading.remove(vacation.requestId);
      });
      final cubit = context.read<VacationsCubit>();
      cubit.getVacations();
      cubit.getRejectedVacations();
      cubit.getPendingVacations();
    } catch (e) {
      setState(() {
        rejectLoading.remove(vacation.requestId);
      });
      debugPrint("Error updating status to Rejected: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<VacationsCubit>();
    return Scaffold(
      appBar: GlobalAppbar(title: S.of(context).request_vacation),
      body: RefreshIndicator(
        onRefresh: () async {
          cubit.vacations.clear();
          cubit.pendingVacations.clear();
          cubit.acceptedVacations.clear();
          cubit.rejectedVacations.clear();
          await cubit.getVacations();
          cubit.getPendingVacations();
          cubit.getAcceptedVacations();
          cubit.getRejectedVacations();
        },
        child: BlocBuilder<VacationsCubit, VacationsState>(
          builder: (context, state) {
            if (state is VacationsInitial || state is VacationsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmptyVacations) {
              return const Center(child: Text("No vacations till now"));
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            pageStatus = 'Pending';
                          });
                          cubit.pendingVacations.clear();
                          cubit.getPendingVacations();
                        },
                        child: const Text('Pending'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            pageStatus = 'Accepted';
                          });
                          cubit.acceptedVacations.clear();
                          cubit.getAcceptedVacations();
                        },
                        child: const Text('Accepted'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            pageStatus = 'Rejected';
                          });
                          cubit.rejectedVacations.clear();
                          cubit.getRejectedVacations();
                        },
                        child: const Text('Rejected'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: pageStatus == 'Pending'
                        ? ListView.builder(
                            itemCount: cubit.pendingVacations.length,
                            itemBuilder: (context, index) {
                              final vacation = cubit.pendingVacations[index];
                              return CustomVacationRequestCard(
                                employeeName: vacation.employeeName,
                                status: vacation.status,
                                startDate: vacation.startDate,
                                endDate: vacation.endDate,
                                reason: vacation.reason,
                                onAccept: () => _onAccept(vacation),
                                onReject: () => _onReject(vacation),
                                acceptLoading:
                                    acceptLoading.contains(vacation.requestId),
                                rejectLoading:
                                    rejectLoading.contains(vacation.requestId),
                              );
                            },
                          )
                        : pageStatus == 'Accepted'
                            ? ListView.builder(
                                itemCount: cubit.acceptedVacations.length,
                                itemBuilder: (context, index) {
                                  final vacation =
                                      cubit.acceptedVacations[index];
                                  return CustomVacationRequestCard(
                                    employeeName: vacation.employeeName,
                                    status: vacation.status,
                                    startDate: vacation.startDate,
                                    endDate: vacation.endDate,
                                    reason: vacation.reason,
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: cubit.rejectedVacations.length,
                                itemBuilder: (context, index) {
                                  final vacation =
                                      cubit.rejectedVacations[index];
                                  return CustomVacationRequestCard(
                                    employeeName: vacation.employeeName,
                                    status: vacation.status,
                                    startDate: vacation.startDate,
                                    endDate: vacation.endDate,
                                    reason: vacation.reason,
                                  );
                                },
                              ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

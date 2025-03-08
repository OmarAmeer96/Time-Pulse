import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_cubit.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_request_card.dart';
import 'package:time_pulse/generated/l10n.dart';

class AdminVrv extends StatefulWidget {
  const AdminVrv({super.key});

  @override
  State<AdminVrv> createState() => _AdminVrvState();
}

class _AdminVrvState extends State<AdminVrv> {
  String pageStatus = 'Pending';
  @override
  void initState() {
    super.initState();
    context.read<VacationsCubit>().vacations.clear();
    context.read<VacationsCubit>().pendingVacations.clear();
    context.read<VacationsCubit>().acceptedVacations.clear();
    context.read<VacationsCubit>().rejectedVacations.clear();
    context.read<VacationsCubit>().getVacations();
    context.read<VacationsCubit>().getPendingVacations();
    context.read<VacationsCubit>().getAcceptedVacations();
    context.read<VacationsCubit>().getRejectedVacations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: S.of(context).request_vacation),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<VacationsCubit>().vacations.clear();
          context.read<VacationsCubit>().pendingVacations.clear();
          context.read<VacationsCubit>().acceptedVacations.clear();
          context.read<VacationsCubit>().rejectedVacations.clear();
          context.read<VacationsCubit>().getVacations();
          context.read<VacationsCubit>().getPendingVacations();
          context.read<VacationsCubit>().getAcceptedVacations();
          context.read<VacationsCubit>().getRejectedVacations();
        },
        child: BlocBuilder<VacationsCubit, VacationsState>(
          builder: (context, state) {
            if (state is VacationsInitial) {
              print('init');
              return Center(child: CircularProgressIndicator());
            }
            if (state is VacationsLoading) {
              print('loading');
              return Center(child: CircularProgressIndicator());
            } else if (state is EmptyVacations) {
              print('empty');
              return Center(child: Text("No vacations till now"));
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            pageStatus = 'Pending';
                            print('Pending');
                            context
                                .read<VacationsCubit>()
                                .pendingVacations
                                .clear();
                            context
                                .read<VacationsCubit>()
                                .getPendingVacations();
                            print(context
                                .read<VacationsCubit>()
                                .pendingVacations);
                          },
                          child: Text('Pending')),
                      TextButton(
                          onPressed: () {
                            pageStatus = 'Accepted';
                            print('Accepted');
                            context
                                .read<VacationsCubit>()
                                .acceptedVacations
                                .clear();
                            context
                                .read<VacationsCubit>()
                                .getAcceptedVacations();
                            print(context
                                .read<VacationsCubit>()
                                .acceptedVacations);
                          },
                          child: Text('Accepted')),
                      TextButton(
                          onPressed: () {
                            pageStatus = 'Rejected';
                            print('Rejected');
                            context
                                .read<VacationsCubit>()
                                .rejectedVacations
                                .clear();
                            context
                                .read<VacationsCubit>()
                                .getRejectedVacations();
                            print(context
                                .read<VacationsCubit>()
                                .rejectedVacations);
                          },
                          child: Text('Rejected')),
                    ],
                  ),
                  pageStatus == 'Pending'
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          child: ListView.builder(
                            itemCount: context
                                .read<VacationsCubit>()
                                .pendingVacations
                                .length,
                            itemBuilder: (context, index) {
                              return CustomVacationRequestCard(
                                employeeName: context
                                    .read<VacationsCubit>()
                                    .pendingVacations[index]
                                    .employeeName,
                                status: context
                                    .read<VacationsCubit>()
                                    .pendingVacations[index]
                                    .status,
                                startDate: context
                                    .read<VacationsCubit>()
                                    .pendingVacations[index]
                                    .startDate,
                                endDate: context
                                    .read<VacationsCubit>()
                                    .pendingVacations[index]
                                    .endDate,
                                reason: context
                                    .read<VacationsCubit>()
                                    .pendingVacations[index]
                                    .reason,
                                onPressed: () {},
                              );
                            },
                          ),
                        )
                      : pageStatus == 'Accepted'
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: context
                                    .read<VacationsCubit>()
                                    .acceptedVacations
                                    .length,
                                itemBuilder: (context, index) {
                                  return CustomVacationRequestCard(
                                    employeeName: context
                                        .read<VacationsCubit>()
                                        .acceptedVacations[index]
                                        .employeeName,
                                    status: context
                                        .read<VacationsCubit>()
                                        .acceptedVacations[index]
                                        .status,
                                    startDate: context
                                        .read<VacationsCubit>()
                                        .acceptedVacations[index]
                                        .startDate,
                                    endDate: context
                                        .read<VacationsCubit>()
                                        .acceptedVacations[index]
                                        .endDate,
                                    reason: context
                                        .read<VacationsCubit>()
                                        .acceptedVacations[index]
                                        .reason,
                                    onPressed: () {},
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: context
                                    .read<VacationsCubit>()
                                    .rejectedVacations
                                    .length,
                                itemBuilder: (context, index) {
                                  return CustomVacationRequestCard(
                                    employeeName: context
                                        .read<VacationsCubit>()
                                        .rejectedVacations[index]
                                        .employeeName,
                                    status: context
                                        .read<VacationsCubit>()
                                        .rejectedVacations[index]
                                        .status,
                                    startDate: context
                                        .read<VacationsCubit>()
                                        .rejectedVacations[index]
                                        .startDate,
                                    endDate: context
                                        .read<VacationsCubit>()
                                        .rejectedVacations[index]
                                        .endDate,
                                    reason: context
                                        .read<VacationsCubit>()
                                        .rejectedVacations[index]
                                        .reason,
                                    onPressed: () {},
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

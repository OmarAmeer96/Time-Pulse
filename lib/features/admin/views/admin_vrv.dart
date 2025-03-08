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
    context.read<VacationsCubit>().getVacations();
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
        },
        child: BlocBuilder<VacationsCubit, VacationsState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          pageStatus = 'Pending';
                        },
                        child: Text(S.of(context).pending)),
                    TextButton(
                        onPressed: () {
                          pageStatus = 'Accepted';
                        },
                        child: Text(S.of(context).accepted)),
                    TextButton(
                        onPressed: () {
                          pageStatus = 'Rejected';
                        },
                        child: Text(S.of(context).rejected)),
                  ],
                ),
                BlocBuilder<VacationsCubit, VacationsState>(
                  builder: (context, state) {
                    if (state is VacationsInitial) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is VacationsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is EmptyVacations) {
                      return Center(child: Text(S.of(context).no_vacation));
                    } else {
                      if (pageStatus == 'Pending') {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: context
                                .read<VacationsCubit>()
                                .pendingVacations
                                .length,
                            itemBuilder: (context, index) {
                              CustomVacationRequestCard(
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
                              return null;
                            },
                          ),
                        );
                      } else if (pageStatus == 'Accepted') {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: context
                                .read<VacationsCubit>()
                                .pendingVacations
                                .length,
                            itemBuilder: (context, index) {
                              CustomVacationRequestCard(
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
                              return null;
                            },
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: context
                                .read<VacationsCubit>()
                                .pendingVacations
                                .length,
                            itemBuilder: (context, index) {
                              CustomVacationRequestCard(
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
                              return null;
                            },
                          ),
                        );
                      }
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

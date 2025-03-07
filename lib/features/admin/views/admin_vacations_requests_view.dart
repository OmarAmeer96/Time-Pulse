import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_cubit.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_button.dart';

class AdminVacationsRequestsView extends StatefulWidget {
  const AdminVacationsRequestsView({super.key});

  @override
  State<AdminVacationsRequestsView> createState() =>
      _AdminVacationsRequestsViewState();
}

class _AdminVacationsRequestsViewState
    extends State<AdminVacationsRequestsView> {
  @override
  void initState() {
    super.initState();
    context.read<VacationsCubit>().vacations.clear();
    context.read<VacationsCubit>().getVacations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: "Vacations Requests"),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<VacationsCubit>().vacations.clear();
          context.read<VacationsCubit>().getVacations();
        },
        child: BlocBuilder<VacationsCubit, VacationsState>(
          builder: (context, state) {
            if (state is VacationsInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is VacationsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EmptyVacations) {
              return Center(
                child: Text("No vacations till now"),
              );
            } else {
              return ListView.builder(
                itemCount: context.read<VacationsCubit>().vacations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context
                                  .read<VacationsCubit>()
                                  .vacations[index]
                                  .employeeName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context
                                            .read<VacationsCubit>()
                                            .vacations[index]
                                            .status ==
                                        "Pending"
                                    ? Constants.yellowColor
                                        .withValues(alpha: 0.1)
                                    : context
                                                .read<VacationsCubit>()
                                                .vacations[index]
                                                .status ==
                                            "Rejected"
                                        ? Constants.redColor
                                            .withValues(alpha: 0.1)
                                        : Constants.greenColor
                                            .withValues(alpha: 0.1),
                              ),
                              child: Text(
                                context
                                    .read<VacationsCubit>()
                                    .vacations[index]
                                    .status,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: context
                                              .read<VacationsCubit>()
                                              .vacations[index]
                                              .status ==
                                          "Pending"
                                      ? Constants.yellowColor
                                      : context
                                                  .read<VacationsCubit>()
                                                  .vacations[index]
                                                  .status ==
                                              "Rejected"
                                          ? Constants.redColor
                                          : Constants.greenColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        GlobalDataShow(
                            title: "Start Date",
                            data: context
                                .read<VacationsCubit>()
                                .vacations[index]
                                .startDate),
                        SizedBox(height: 8),
                        GlobalDataShow(
                            title: "End Date",
                            data: context
                                .read<VacationsCubit>()
                                .vacations[index]
                                .endDate),
                        SizedBox(height: 8),
                        GlobalDataShow(
                            title: "Reason",
                            data: context
                                .read<VacationsCubit>()
                                .vacations[index]
                                .reason),
                        SizedBox(height: 8),
                        context
                                    .read<VacationsCubit>()
                                    .vacations[index]
                                    .status ==
                                "Pending"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 25,
                                children: [
                                  CustomVacationButton(
                                    onPressed: () {
                                      Accept(index);
                                    },
                                  ),
                                  CustomVacationButton(
                                    onPressed: () {
                                      Reject(index);
                                    },
                                    isAccept: false,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ).decorate(padding: 12,context: context),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Accept(int index) {
    context.read<VacationsCubit>().vacations[index].status = "Accepted";
  }

  Reject(int index) {
    context.read<VacationsCubit>().vacations[index].status = "Rejected";
  }
}

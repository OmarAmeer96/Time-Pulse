import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_cubit.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_button.dart';
import 'package:time_pulse/generated/l10n.dart';

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

  void accept(int index) {
    setState(() {
      context.read<VacationsCubit>().vacations[index].status = "Accepted";
    });
  }

  void reject(int index) {
    setState(() {
      context.read<VacationsCubit>().vacations[index].status = "Rejected";
    });
  }

  @override
  Widget build(BuildContext context) {
    final vacationsCubit = context.watch<VacationsCubit>();
    return Scaffold(
      appBar: GlobalAppbar(title: S.of(context).request_vacation),
      body: RefreshIndicator(
        onRefresh: () async {
          vacationsCubit.vacations.clear();
          await vacationsCubit.getVacations();
        },
        child: BlocBuilder<VacationsCubit, VacationsState>(
          builder: (context, state) {
            if (state is VacationsInitial || state is VacationsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmptyVacations) {
              return Center(child: Text(S.of(context).no_vacation));
            } else {
              return ListView.builder(
                itemCount: vacationsCubit.vacations.length,
                itemBuilder: (context, index) {
                  final vacation = vacationsCubit.vacations[index];
                  Color statusColor;
                  Color statusBg;
                  if (vacation.status == "Pending") {
                    statusColor = Constants.yellowColor;
                    statusBg = Constants.yellowColor.withValues(alpha: 0.1);
                  } else if (vacation.status == "Rejected") {
                    statusColor = Constants.redColor;
                    statusBg = Constants.redColor.withValues(alpha: 0.1);
                  } else {
                    statusColor = Constants.greenColor;
                    statusBg = Constants.greenColor.withValues(alpha: 0.1);
                  }
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
                              vacation.employeeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: statusBg,
                              ),
                              child: Text(
                                vacation.status,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        GlobalDataShow(
                          title: S.of(context).start_date,
                          data: vacation.startDate,
                        ),
                        const SizedBox(height: 8),
                        GlobalDataShow(
                          title: S.of(context).end_date,
                          data: vacation.endDate,
                        ),
                        const SizedBox(height: 8),
                        GlobalDataShow(
                          title: S.of(context).search,
                          data: vacation.reason,
                        ),
                        const SizedBox(height: 8),
                        if (vacation.status == "Pending")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomVacationButton(
                                onPressed: () => accept(index),
                              ),
                              const SizedBox(width: 25),
                              CustomVacationButton(
                                onPressed: () => reject(index),
                                isAccept: false,
                              ),
                            ],
                          )
                      ],
                    ).decorate(padding: 12, context: context),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

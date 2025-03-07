import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/cubit/employee_history_cubit/employee_history_cubit.dart';
import 'package:time_pulse/features/admin/cubit/employee_history_cubit/employee_history_state.dart';
import 'package:time_pulse/features/history/cubit/history_cubit.dart';

class EmployeeHistoryView extends StatefulWidget {
  const EmployeeHistoryView({super.key});

  @override
  State<EmployeeHistoryView> createState() => _EmployeeHistoryViewState();
}

class _EmployeeHistoryViewState extends State<EmployeeHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeHistoryCubit>().employeeHistory.clear();
    context.read<EmployeeHistoryCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: "Employee History"),
      body: BlocBuilder<EmployeeHistoryCubit, EmployeeHistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HistoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmptyHistory) {
            return Center(
              child: Text("Empty History"),
            );
          } else {
            return ListView.builder(
              itemCount: context.read<EmployeeHistoryCubit>().employeeHistory.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                  child: Column(
                    children: [
                      GlobalDataShow(
                        title: "Check-in time",
                        data: context
                            .read<EmployeeHistoryCubit>()
                            .employeeHistory[index]
                            .checkInTime,
                      ),
                      SizedBox(height: 8),
                      GlobalDataShow(
                        title: "Check-out time",
                        data: context
                            .read<EmployeeHistoryCubit>()
                            .employeeHistory[index]
                            .checkOutTime,
                      ),
                    ],
                  ).decorate(padding: 8),
                );
              },
            );
          }
        },
      ),
    );
  }
}

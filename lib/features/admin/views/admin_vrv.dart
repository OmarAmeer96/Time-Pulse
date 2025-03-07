import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_cubit.dart';
import 'package:time_pulse/features/admin/cubit/vacations_cubit/vacations_state.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_button.dart';

class AdminVrv extends StatefulWidget {
  const AdminVrv({super.key});

  @override
  State<AdminVrv> createState() => _AdminVrvState();
}

class _AdminVrvState extends State<AdminVrv> {
  @override
  void initState() {
    super.initState();
    context.read<VacationsCubit>().vacations.clear();
    context.read<VacationsCubit>().getVacations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: 'Vacations Requests'),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<VacationsCubit>().vacations.clear();
          context.read<VacationsCubit>().getVacations();
        },
        child: BlocBuilder<VacationsCubit, VacationsState>(
          builder: (context, state) {
            return Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                TextButton(onPressed: () {}, child: Text('Pending')),
                TextButton(onPressed: () {}, child: Text('Accepted')),
                TextButton(onPressed: () {}, child: Text('Rejected')),
              ])
            ]);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';
import 'package:time_pulse/features/vacation_request/vacation_request_view.dart';
import 'package:time_pulse/features/vacations_history/cubit/vacations_history_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

class VacationsHistoryView extends StatefulWidget {
  const VacationsHistoryView({super.key});

  @override
  State<VacationsHistoryView> createState() => _VacationsHistoryViewState();
}

class _VacationsHistoryViewState extends State<VacationsHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<VacationsHistoryCubit>().vacationsHistory.clear();
    context.read<VacationsHistoryCubit>().getVacationsHistory();
  }

  @override
  Widget build(BuildContext context) {
    var theme= context.read<ThemeCubit>();
    return Scaffold(
      appBar: GlobalAppbar(title: S.of(context).vacations),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VacationRequestView(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<VacationsHistoryCubit>().vacationsHistory.clear();
          context.read<VacationsHistoryCubit>().getVacationsHistory();
        },
        child: BlocBuilder<VacationsHistoryCubit, VacationsHistoryState>(
          builder: (context, state) {
            if (state is VacationsHistoryInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is VacationsHistoryLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EmptyVacationsHistory) {
              return Center(
                child: Text(S.of(context).no_vacation,style: TextStyle(color: theme.darkMode?Colors.white70:Colors.black54 ),),
              );
            } else {
              return ListView.builder(
                itemCount: context
                    .read<VacationsHistoryCubit>()
                    .vacationsHistory
                    .length,
                itemBuilder: (context, index) {
                  String status = context
                      .read<VacationsHistoryCubit>()
                      .vacationsHistory[index]
                      .status ;
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "#${context.read<VacationsHistoryCubit>().vacationsHistory[index].requestId}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: status == "Pending"
                                      ? Constants.yellowColor
                                          .withValues(alpha: 0.1)
                                      : status == "Rejected"
                                          ? Constants.redColor
                                              .withValues(alpha: 0.1)
                                          : Constants.greenColor
                                              .withValues(alpha: 0.1),
                                ),
                                child: Text(
                                 status=="Pending"?S.of(context).pending:status=="Rejected"?S.of(context).rejected:S.of(context).accepted,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: status == "Pending"
                                          ? Constants.yellowColor
                                          : status =="Rejected"
                                              ? Constants.redColor
                                              : Constants.greenColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          GlobalDataShow(
                              title: S.of(context).start_date,
                              data: context
                                  .read<VacationsHistoryCubit>()
                                  .vacationsHistory[index]
                                  .startDate),
                          SizedBox(height: 8),
                          GlobalDataShow(
                              title: S.of(context).end_date,
                              data: context
                                  .read<VacationsHistoryCubit>()
                                  .vacationsHistory[index]
                                  .endDate),
                          SizedBox(height: 8),
                          GlobalDataShow(
                              title: S.of(context).reason,
                              data: context
                                  .read<VacationsHistoryCubit>()
                                  .vacationsHistory[index]
                                  .reason),
                        ],
                      ).decorate(padding: 12,context: context));
                },
              );
            }
          },
        ),
      ),
    );
  }
}

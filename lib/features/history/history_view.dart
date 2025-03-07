import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/history/cubit/history_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().userHistory.clear();
    context.read<HistoryCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: S.of(context).history),
      body: BlocBuilder<HistoryCubit, HistoryState>(
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
              child: Text(S.of(context).empty_history),
            );
          } else {
            return ListView.builder(
              itemCount: context.read<HistoryCubit>().userHistory.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Column(
                      children: [
                        GlobalDataShow(
                            title: S.of(context).check_in,
                            data: context
                                .read<HistoryCubit>()
                                .userHistory[index]
                                .checkInTime),
                        SizedBox(height: 8),
                        GlobalDataShow(
                            title: S.of(context).check_out,
                            data: context
                                .read<HistoryCubit>()
                                .userHistory[index]
                                .checkOutTime),
                      ],
                    ).decorate(padding: 8,context: context));
              },
            );
          }
        },
      ),
    );
  }
}

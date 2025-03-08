import 'package:flutter/material.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_button.dart';
import 'package:time_pulse/generated/l10n.dart';

class CustomVacationRequestCard extends StatelessWidget {
  const CustomVacationRequestCard({
    Key? key,
    required this.employeeName,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.onAccept,
    this.onReject,
    this.acceptLoading = false,
    this.rejectLoading = false,
  }) : super(key: key);

  final String employeeName;
  final String status;
  final String startDate;
  final String endDate;
  final String reason;
  final GestureTapCallback? onAccept;
  final GestureTapCallback? onReject;
  final bool acceptLoading;
  final bool rejectLoading;

  @override
  Widget build(BuildContext context) {
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
                employeeName,
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
                  color: status == "Pending"
                      ? Constants.yellowColor.withValues(alpha: 0.1)
                      : status == "Rejected"
                          ? Constants.redColor.withValues(alpha: 0.1)
                          : Constants.greenColor.withValues(alpha: 0.1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: status == "Pending"
                        ? Constants.yellowColor
                        : status == "Rejected"
                            ? Constants.redColor
                            : Constants.greenColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          GlobalDataShow(
            title: S.of(context).start_date,
            data: startDate,
          ),
          const SizedBox(height: 8),
          GlobalDataShow(
            title: S.of(context).end_date,
            data: endDate,
          ),
          const SizedBox(height: 8),
          GlobalDataShow(
            title: "Reason",
            data: reason,
          ),
          const SizedBox(height: 8),
          if (status == "Pending")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomVacationButton(
                  onPressed: onAccept,
                  isAccept: true,
                  isLoading: acceptLoading,
                ),
                CustomVacationButton(
                  onPressed: onReject,
                  isAccept: false,
                  isLoading: rejectLoading,
                ),
              ],
            )
        ],
      ).decorate(padding: 12, context: context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:time_pulse/core/widgets/global_data_show.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/admin/widgets/custom_vacation_button.dart';

class CustomVacationRequestCard extends StatelessWidget {
  const CustomVacationRequestCard({
    super.key,
    required this.employeeName,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.onPressed,
  });

  final String employeeName;
  final String status;
  final String startDate;
  final String endDate;
  final String reason;
  final GestureTapCallback? onPressed;

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
          SizedBox(height: 10),
          GlobalDataShow(
            title: "Start Date",
            data: startDate,
          ),
          SizedBox(height: 8),
          GlobalDataShow(
            title: "End Date",
            data: endDate,
          ),
          SizedBox(height: 8),
          GlobalDataShow(
            title: "Reason",
            data: reason,
          ),
          SizedBox(height: 8),
          status == "Pending"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomVacationButton(
                      onPressed: onPressed,
                    ),
                    CustomVacationButton(
                      onPressed: onPressed,
                      isAccept: false,
                    ),
                  ],
                )
              : Container()
        ],
      ).decorate(padding: 12),
    );
  }
}

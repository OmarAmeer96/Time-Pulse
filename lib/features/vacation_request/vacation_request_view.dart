import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/widgets/custom_button.dart';
import 'package:time_pulse/core/widgets/custom_text_form_field.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_loading_dialog.dart';
import 'package:time_pulse/features/vacation_request/cubit/vacation_request_cubit.dart';
import 'package:time_pulse/features/vacations_history/cubit/vacations_history_cubit.dart';

class VacationRequestView extends StatefulWidget {
  const VacationRequestView({super.key});

  @override
  State<VacationRequestView> createState() => _VacationRequestViewState();
}

class _VacationRequestViewState extends State<VacationRequestView> {
  @override
  void initState() {
    super.initState();
    context.read<VacationRequestCubit>().getUserRemainingleaves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: "Request Vacation"),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - (kToolbarHeight + 30),
          child: Form(
            key: context.read<VacationRequestCubit>().vacationRequestFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                    readOnly: true,
                    controller: context
                        .read<VacationRequestCubit>()
                        .startDateController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please select a start date";
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      await context
                          .read<VacationRequestCubit>()
                          .selectStartDate(context);
                    },
                    label: "Start Date",
                    prefixIcon: Icon(Icons.calendar_month)),
                CustomTextFormField(
                    readOnly: true,
                    controller:
                        context.read<VacationRequestCubit>().endDateController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please select an end date";
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      await context
                          .read<VacationRequestCubit>()
                          .selectEndDate(context);
                    },
                    label: "End Date",
                    prefixIcon: Icon(Icons.calendar_month)),
                CustomTextFormField(
                    maxLines: 5,
                    controller:
                        context.read<VacationRequestCubit>().reasonController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a reason for your request";
                      } else {
                        return null;
                      }
                    },
                    label: "Reason",
                    prefixIcon: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Icon(Icons.note_alt_sharp),
                      ),
                    )),
                Spacer(),
                SafeArea(
                  child:
                      BlocListener<VacationRequestCubit, VacationRequestState>(
                    listener: (context, state) {
                      if (state is VacationRequestLoading) {
                        GlobalDialog.showLoadingDialog(context);
                      } else if (state is VacationRequestLoaded) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Request submitted successfully");
                      } else if (state is VacationRequestUnavailable) {
                        Fluttertoast.showToast(
                            msg: "Sorry, Your remaining balance is zero");
                      }
                    },
                    child: CustomButton(
                        icon: SizedBox(),
                        text: "Submit",
                        onPressed: () async {
                          if (context
                              .read<VacationRequestCubit>()
                              .vacationRequestFormKey
                              .currentState!
                              .validate()) {
                            await context
                                .read<VacationRequestCubit>()
                                .submitVacationRequest();
                            context
                                .read<VacationsHistoryCubit>()
                                .vacationsHistory
                                .clear();
                            context
                                .read<VacationsHistoryCubit>()
                                .getVacationsHistory();
                            Navigator.pop(context);
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

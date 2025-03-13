import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/widgets/custom_button.dart';
import 'package:time_pulse/core/widgets/custom_text_form_field.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_loading_dialog.dart';
import 'package:time_pulse/features/vacation_request/cubit/vacation_request_cubit.dart';
import 'package:time_pulse/features/vacations_history/cubit/vacations_history_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

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
      appBar: GlobalAppbar(title: S.of(context).request_vacation),
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
                        return S.of(context).select_a_start_date;
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      await context
                          .read<VacationRequestCubit>()
                          .selectStartDate(context);
                    },
                    label: S.of(context).start_date,
                    prefixIcon: const Icon(Icons.calendar_month)),
                CustomTextFormField(
                    readOnly: true,
                    controller:
                        context.read<VacationRequestCubit>().endDateController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).select_a_end_date;
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      await context
                          .read<VacationRequestCubit>()
                          .selectEndDate(context);
                    },
                    label: S.of(context).end_date,
                    prefixIcon: const Icon(Icons.calendar_month)),
                CustomTextFormField(
                    maxLines: 5,
                    controller:
                        context.read<VacationRequestCubit>().reasonController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).select_a_reason;
                      } else {
                        return null;
                      }
                    },
                    label: S.of(context).reason,
                    prefixIcon: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Icon(Icons.note_alt_sharp),
                      ),
                    )),
                const Spacer(),
                SafeArea(
                  child:
                      BlocListener<VacationRequestCubit, VacationRequestState>(
                    listener: (context, state) {
                      if (state is VacationRequestLoading) {
                        GlobalDialog.showLoadingDialog(context);
                      } else if (state is VacationRequestLoaded) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: S.of(context).request_submitted);
                      } else if (state is VacationRequestUnavailable) {
                        Fluttertoast.showToast(
                            msg: S.of(context).remaining_balance);
                      }
                    },
                    child: CustomButton(
                        icon: const SizedBox(),
                        text: S.of(context).submit,
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

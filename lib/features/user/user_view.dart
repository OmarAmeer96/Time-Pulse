import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_loading_dialog.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/features/user/cubit/user_cubit.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalAppbar(title: "HomePage"),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 8),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Text(
                    "Welcome Back, ${state.employeeName} 👋",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  );
                },
              ),
            ),
            Text(context.watch<UserCubit>().isCheckedIn
                ? "Please click here to check out"
                : "Please click here to check in"),
            Expanded(
              child: BlocListener<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UserCheckedIn) {
                      Fluttertoast.showToast(msg: "Checked in successfully");
                    } else if (state is UserCheckedOut) {
                      Fluttertoast.showToast(msg: "Checked out successfully");
                    } else if (state is UserNotInCompanyArea) {
                      Fluttertoast.showToast(
                          msg: "You are out of company area");
                    } else if (state is UserLocationLoading) {
                      GlobalDialog.showLoadingDialog(context);
                    } else if (state is UserLocationLoaded) {
                      Navigator.pop(context);
                    }
                  },
                  child: UnconstrainedBox(
                    child: IconButton(
                      onPressed: () {
                        context.read<UserCubit>().getTime();
                        context.read<UserCubit>().checkInAndOut();
                        context
                            .read<UserCubit>()
                            .addCheckInAndOutTimeToFirebase();
                      },
                      icon: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.4,
                          backgroundColor:
                              context.watch<UserCubit>().isCheckedIn
                                  ? Constants.redColor.withValues(alpha: 0.1)
                                  : MyTheme.primaryColor.withValues(alpha: 0.1),
                          child: Image.asset(
                            'assets/images/check_in_and_out.png',
                            color: context.watch<UserCubit>().isCheckedIn
                                ? Constants.redColor
                                : MyTheme.primaryColor,
                            width: MediaQuery.of(context).size.width * 0.4,
                          )),
                    ),
                  )),
            ),
          ]),
        ));
  }
}

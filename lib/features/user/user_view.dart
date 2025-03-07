import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/core/widgets/global_loading_dialog.dart';
import 'package:time_pulse/data/constants/constants.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';
import 'package:time_pulse/features/user/cubit/user_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

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
    var theme= context.read<ThemeCubit>();
    return Scaffold(
        appBar: GlobalAppbar(title: S.of(context).home_page),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 8),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Text(
                    "${S.of(context).welcome}, ${state.employeeName} 👋",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500 ,color: theme.darkMode?Colors.white:Colors.black),
                  );
                },
              ),
            ),
            Text(context.watch<UserCubit>().isCheckedIn
                ? S.of(context).click_to_check_out
                : S.of(context).click_to_check_in,
            style: TextStyle(
                color: theme.darkMode?Colors.white:Colors.black),
            ),
            Expanded(
              child: BlocListener<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UserCheckedIn) {
                      Fluttertoast.showToast(msg:  S.of(context).checked_in);
                    } else if (state is UserCheckedOut) {
                      Fluttertoast.showToast(msg: S.of(context).checked_out);
                    } else if (state is UserNotInCompanyArea) {
                      Fluttertoast.showToast(
                          msg: S.of(context).out_of_company);
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
                                  :MyTheme.primaryColor.withValues(alpha:theme.darkMode?0.4: 0.1),
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

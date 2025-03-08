import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_cubit.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/features/admin/widgets/create_employee_view.dart';
import 'package:time_pulse/features/admin/widgets/custom_list_tile.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().employees.clear();
    context.read<AdminCubit>().getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.read<ThemeCubit>().darkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryColor,
        iconTheme: IconThemeData(color: theme ? Colors.grey : Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.view_timeline,
                color: theme ? Colors.grey : Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, Routes.adminVrv);
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: theme ? Colors.grey : Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.settingsView);
          },
        ),
        title: Text(
          S.of(context).employee_data,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AdminCubit>().employees.clear();
          context.read<AdminCubit>().getEmployeeData();
        },
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is AdminPageInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AdminPageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AdminPageLoaded || state is EmployeeAdded) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomTextField(
                      hintText: S.of(context).search,
                      controller: searchController,
                      icon: Icons.search,
                      onSubmitted: () {},
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: context.read<AdminCubit>().employees.length,
                        itemBuilder: (context, index) {
                          return CustomListTile(
                            onTap: () {
                              SharedPrefHelper.setData(
                                "employeeHistoryId",
                                context.read<AdminCubit>().employees[index].id,
                              );
                              Navigator.pushNamed(
                                context,
                                Routes.employeeHistoryView,
                              );
                            },
                            employeeName: context
                                .read<AdminCubit>()
                                .employees[index]
                                .name,
                            employeeId:
                                context.read<AdminCubit>().employees[index].id,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(S.of(context).error),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme ? Colors.grey : Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CreateEmployee();
            },
          );
        },
        child: Icon(
          Icons.person_add_rounded,
          size: 30,
          color: MyTheme.primaryColor,
        ),
      ),
    );
  }
}

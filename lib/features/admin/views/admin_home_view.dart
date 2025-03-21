import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_cubit.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/features/admin/widgets/create_employee_view.dart';
import 'package:time_pulse/features/admin/widgets/custom_list_tile.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';
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
    context.read<AdminCubit>().getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.view_timeline,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.adminVrv);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              context.read<AdminCubit>().logout();
              Navigator.pushReplacementNamed(context, Routes.loginView);
              await SharedPrefHelper.setData("isUserLoggedIn", false);
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.settings,
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
        onRefresh: () async => context.read<AdminCubit>().getEmployeeData(),
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            final cubit = context.read<AdminCubit>();

            if (state is AdminPageLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AdminPageError) {
              return Center(child: Text(S.of(context).error));
            }

            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomTextField(
                    hintText: S.of(context).search,
                    controller: searchController,
                    icon: Icons.search,
                    onChanged: (query) => cubit.filterEmployees(query),
                    onSubmitted: (query) => cubit.filterEmployees(query),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: cubit.filteredEmployees.length,
                      itemBuilder: (context, index) {
                        final employee = cubit.filteredEmployees[index];
                        return (employee.role != "admin")
                            ? CustomListTile(
                                imageUrl: employee.imageUrl,
                                onTap: () {
                                  SharedPrefHelper.setData(
                                    "employeeHistoryId",
                                    employee.id,
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    Routes.employeeHistoryView,
                                  );
                                },
                                employeeName: employee.name,
                                employeeRemainingLeaves:
                                    employee.remaining_leaves.toString(),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const CreateEmployee(),
          ),
        ),
        child: Icon(
          Icons.person_add_rounded,
          size: 30,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_cubit.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_state.dart';
import 'package:time_pulse/features/admin/widgets/create_employee_view.dart';
import 'package:time_pulse/features/admin/widgets/custom_list_tile.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';

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
        backgroundColor: MyTheme.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.view_timeline, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, Routes.adminVacationsView);
            },
          ),
        ],
        title: Text(
          'Employees Data',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AdminCubit, AdminState>(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomTextField(
                    hintText: 'Search',
                    controller: searchController,
                    icon: Icons.search,
                    onSubmitted: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: MyTheme.primaryColor,
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                      itemCount: context.read<AdminCubit>().employees.length,
                      itemBuilder: (context, index) {
                        return CustomListTile(
                          employeeName:
                              context.read<AdminCubit>().employees[index].name,
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
              child: Text('Error'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
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
          color: MyTheme.primaryColor,
        ),
      ),
    );
  }
}

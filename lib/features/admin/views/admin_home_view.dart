import 'package:flutter/material.dart';
import 'package:time_pulse/features/admin/employee_model.dart';
import 'package:time_pulse/features/admin/services/get_employee_data.dart';
import 'package:time_pulse/features/admin/widgets/create_employee_view.dart';
import 'package:time_pulse/features/admin/widgets/custom_list_tile.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  List<EmployeeModel> employees = [];

  @override
  void initState() {
    super.initState();
    getEmployees();
  }

  Future<void> getEmployees() async {
    employees = await EmployeeService().getEmployeeData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employees Data',
          style: TextStyle(color: Color(0xff80c6c5)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.85,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  employeeName: employees[index].name,
                  employeeId: employees[index].id,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CreateEmployee();
            },
          );
          // setState(() {});
        },
        child: Icon(Icons.person_add_rounded),
      ),
    );
  }
}

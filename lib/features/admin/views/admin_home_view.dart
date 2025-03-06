import 'package:flutter/material.dart';
import 'package:time_pulse/features/admin/employee_model.dart';
import 'package:time_pulse/features/admin/services/get_employee_data.dart';
import 'package:time_pulse/features/admin/widgets/create_employee_view.dart';
import 'package:time_pulse/features/admin/widgets/custom_list_tile.dart';
import 'package:time_pulse/features/admin/widgets/custom_text_field.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  List<EmployeeModel> employees = [];

  final TextEditingController searchController = TextEditingController();

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
        actions: [
          IconButton(
            icon: const Icon(Icons.view_timeline),
            onPressed: () {}
          )
        ],
        title: const Text(
          'Employees Data',
          style: TextStyle(color: Color(0xff80c6c5)),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                color: Color(0xff80c6c5),
              ),
              height: MediaQuery.sizeOf(context).height * 0.75,
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
          ),
        ],
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
          color: Color(0xff80c6c5),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmployeeHistoryView extends StatefulWidget {
  const EmployeeHistoryView({super.key});

  @override
  State<EmployeeHistoryView> createState() => _EmployeeHistoryViewState();
}

class _EmployeeHistoryViewState extends State<EmployeeHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person),
              Text('Employee Name'),
              Spacer(),
              Text('Employee ID'),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Column(children: [
                    Icon(Icons.calendar_month_rounded),
                    Text('Date'),
                  ]),
                  Column(children: [
                    Icon(Icons.login_rounded, color: Colors.green),
                    Text('CheckIn'),
                  ]),
                  Column(children: [
                    Icon(Icons.logout_rounded, color: Colors.red),
                    Text('CheckOut'),
                  ]),
                ],
              ),
              ListView(
                children: [
                  Row(
                    children: [
                      Text('date'),
                      Text('checkin'),
                      Text('checkout'),
                    ]
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

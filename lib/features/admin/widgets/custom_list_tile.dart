import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('Employee Name'),
      subtitle: Text('Employee ID'),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}

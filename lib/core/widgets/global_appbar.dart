import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions ;
   GlobalAppbar({required this.title, super.key ,this.actions =null});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      centerTitle: true,
      backgroundColor: MyTheme.primaryColor,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 5);
}

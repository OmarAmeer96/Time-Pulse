import 'package:flutter/material.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions;
  GlobalAppbar({required this.title, super.key, this.actions = null});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 5);
}

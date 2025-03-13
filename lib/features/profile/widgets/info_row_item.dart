import 'package:flutter/material.dart';

Widget infoRowItem(String title, String value, bool theme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: theme ? Colors.grey.shade400 : Colors.grey.shade700,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme ? Colors.white : Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';

Widget infoRowItem(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade700,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

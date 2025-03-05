import 'package:flutter/material.dart';

extension CustomBoxDecoration on Widget {
  Widget decorate({double? padding}) {
    return Container(
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF767676).withValues(alpha: 0.1),
              blurRadius: 7,
              offset: const Offset(0, 6),
            ),
          ]),
      child: this,
    );
  }
}

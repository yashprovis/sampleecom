import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class HelperMethods {
  static showSnack(
      {required BuildContext context,
      required String message,
      Color? color,
      double? margin}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: margin ?? 30, left: 20, right: 20),
      content: EcomText(
        message,
        size: 14,
        color: Colors.white,
      ),
      backgroundColor: color ?? Colors.black,
    ));
  }
}

String formatNumber(num value) {
  var formatter = NumberFormat('#,##,000');
  return formatter.format(value);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase().replaceAll("*", '')}";
  }
}
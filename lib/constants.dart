import 'package:flutter/material.dart';

const String baseUrl = "http://192.168.100.43:5000/api";
const String uploadUrl = "http://192.168.100.43:5000/uploads";

String notificationUrl = '';

const Map<String, String> headerApiMap = {
  "Content-Type": "application/json; charset=utf-8",
  "Accept": "*/*"
};
const Color primaryColor = Color(0xFF080808);
const Color greyColor = Color(0xFFD6D6D6);
InputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
InputBorder errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);

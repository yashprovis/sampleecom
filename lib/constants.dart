import 'package:flutter/material.dart';

const String baseUrl = "http://192.168.2.103:5000/api";
const String uploadUrl = "http://192.168.2.103:5000/uploads";

const Map<String, String> headerApiMap = {
  "Content-Type": "application/json; charset=utf-8",
  "Accept": "*/*"
};
const Color primaryColor = Colors.black;
const Color greyColor = Color(0xFFD6D6D6);
InputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
InputBorder errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);

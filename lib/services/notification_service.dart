import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';

class NotificationService {
  Future<String?> saveDeviceToken(String uid) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken != null) {
      Map req = {"token": deviceToken, "uid": uid};

      await saveDeviceTokenApi(req);
    }
    return deviceToken;
  }

  Future saveDeviceTokenApi(Map req) async {
    http.Response response = await http.post(
        body: jsonEncode(req),
        headers: headerApiMap,
        Uri.parse("$baseUrl/addToken"));
    jsonDecode(response.body)['data'];
  }
}

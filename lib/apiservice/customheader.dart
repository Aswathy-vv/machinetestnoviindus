import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CustomHeaders {
  Future<Map<String, String>> getHeaders() async {
    final Map<String, String> headers = {
      "Content-Type": "application/json;charset=UTF-8",
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginDataString = prefs.getString("loginData"); // correct key
    if (loginDataString != null) {
      Map<String, dynamic> loginData = json.decode(loginDataString);
      String? token = loginData["token"];
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token"; // Add token to headers
      }
    }

    return headers;
  }
}

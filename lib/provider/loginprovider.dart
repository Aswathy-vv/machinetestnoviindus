import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:machinetestnoviindus/apiservice/sharedpreferencehelper.dart';
import 'package:machinetestnoviindus/repo/loginrepo.dart';

class AuthProvider extends ChangeNotifier {
  Future<Map<String, dynamic>> loginprovider(
      String countryCode, String phone) async {
    Map<String, dynamic> response = {
      "status": false,
      "message": "Login failed"
    };

    try {
      var body = {
        "country_code": countryCode,
        "phone": phone,
      };

      response = await AuthRepo().login(body);
      log(response.toString());

      final accessToken = response["token"]?["access"];
      final refreshToken = response["token"]?["refresh"];

      if (accessToken != null) {
        await SharedPreferencesHelper.saveData("loginData", {
          "token": accessToken,
          "refreshToken": refreshToken,
          "phone": phone,
        });
      }
    } catch (e) {
      log("Login error: $e");
    }

    return response;
  }
}

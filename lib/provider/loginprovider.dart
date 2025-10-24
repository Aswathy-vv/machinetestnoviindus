import 'dart:developer';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:machinetestnoviindus/apiservice/sharedpreferencehelper.dart';
import 'package:machinetestnoviindus/constants/Approutes.dart';
import 'package:machinetestnoviindus/constants/customsnackbar.dart';
import 'package:machinetestnoviindus/repo/loginrepo.dart';
import 'package:machinetestnoviindus/screens/homescreen.dart';

class AuthProvider extends ChangeNotifier {
  Future<Map<String, dynamic>> loginprovider(
      String countryCode, String phone) async {
    try {
      var body = {
        "country_code": countryCode,
        "phone": phone,
      };

      var response = await AuthRepo().login(body);
      log(response.toString());

      if (response["status"] == true) {
        final accessToken = response["token"]?["access"];
        final refreshToken = response["token"]?["refresh"];

        if (accessToken != null) {
          // Save login data
          await SharedPreferencesHelper.saveData("loginData", {
            "token": accessToken,
            "refreshToken": refreshToken,
            "phone": phone,
            // "privilege": response["privilage"],
          });

          // Show success SnackBar

          return {
            "status": true,
            "message": response["message"] ?? "Login successful",
          };
        } else {
          // Invalid response from server

          return {
            "status": false,
            "message": "Invalid response from server",
          };
        }
      } else {
        // Login failed

        return {
          "status": false,
          "message": response["message"] ?? "Login failed",
        };
      }
    } catch (e) {
      log("Login error: $e");

      return {
        "status": false,
        "message": "Something went wrong, please try again",
      };
    }
  }
}

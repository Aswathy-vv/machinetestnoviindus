import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/apiservice/sharedpreferencehelper.dart';
import 'package:machinetestnoviindus/repo/addfeedrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addfeedprovider extends ChangeNotifier {
  Future<Map<String, dynamic>> addfeedprovider(
    String image,
    String video,
    String desc,
    List<int> categories, // <- list here
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? loginDataString = prefs.getString("loginData");
    if (loginDataString == null) return {};

    Map<String, dynamic> loginData = json.decode(loginDataString);
    String? token = loginData["token"];
    if (token == null || token.isEmpty) return {};

    var body = {
      "image": image,
      "video": video,
      "desc": desc,
      "category": categories, // send list
    };

    // Use your repo which posts JSON (make sure it sends Authorization header)
    var response = await Addfeedrepo().addfeed(body);
    log("${response.toString()},${categories}");
    return response;
  }

  Map<String, dynamic>? feedData;

  Future<void> fetchfeedData() async {
    notifyListeners();

    try {
      final response = await Addfeedrepo().myfeed();
      feedData = response;
      log("Banner data: $response");
    } catch (e) {
      log("Error fetching banner data: $e");
    }

    notifyListeners();
  }
}

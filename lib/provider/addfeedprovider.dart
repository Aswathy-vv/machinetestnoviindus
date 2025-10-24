import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/apiservice/sharedpreferencehelper.dart';
import 'package:machinetestnoviindus/constants/urls.dart';
import 'package:machinetestnoviindus/repo/addfeedrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addfeedprovider extends ChangeNotifier {
  Future<Map<String, dynamic>> addfeedprovider(
    String imagePath,
    String videoPath,
    String desc,
    List<int> categories, // list of category IDs
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? loginDataString = prefs.getString("loginData");
    if (loginDataString == null) return {};

    Map<String, dynamic> loginData = json.decode(loginDataString);
    String? token = loginData["token"];
    if (token == null || token.isEmpty) return {};

    var uri =
        Uri.parse(Urls.BASE_URL + Urls.MYFEED); // replace with your endpoint
    var request = http.MultipartRequest('POST', uri);

    // Add image and video files
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.files.add(await http.MultipartFile.fromPath('video', videoPath));

    // Add description
    request.fields['desc'] = desc;

    // Add categories — each ID as a separate field
    for (var id in categories) {
      request.fields['catogory'] = id.toString(); // must match backend key
    }

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Send request
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    log(responseBody);

    return json.decode(responseBody);
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

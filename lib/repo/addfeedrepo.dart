import 'dart:convert';
import 'dart:developer';

import 'package:machinetestnoviindus/apiservice/webservice.dart';
import 'package:machinetestnoviindus/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addfeedrepo {
  ApiService apiService = ApiService();

  Future<Map<String, dynamic>> addfeed(body) async {
    final response = await apiService.postResponse(
        Urls.MYFEED, jsonEncode(body)); // sends JSON
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<Map<String, dynamic>> myfeed() async {
    try {
      var response = await Addfeedrepo().apiService.getResponse(
            Urls.MYFEED,
          );

      if (response.statusCode == 200) {
        return json.decode(utf8.decode(response.bodyBytes));
      } else {
        print("Error fetching myfeed: ${response.statusCode}");
        print("Response body: ${utf8.decode(response.bodyBytes)}");
        return {};
      }
    } catch (e) {
      print("Error fetching myfeed: $e");
      return {};
    }
  }
}

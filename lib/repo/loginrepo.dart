import 'dart:convert';

import 'package:machinetestnoviindus/apiservice/webservice.dart';
import 'package:machinetestnoviindus/constants/urls.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  Future<Map<String, dynamic>> login(var credentials) async {
    var response =
        await apiService.postResponse(Urls.LOGIN, jsonEncode(credentials));
    Map<String, dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));
    ;
    return responseData;
  }

  // Future<Map<String, dynamic>> createpassw(var credentials) async {
  //   log("body is $credentials");
  //   var response = await apiService.postResponse(
  //       Urls.createpassw, jsonEncode(credentials));
  //   Map<String, dynamic> responseData =
  //       json.decode(utf8.decode(response.bodyBytes));
  //   ;
  //   return responseData;
  // }

  // Future<Map<String, dynamic>> interest() async {
  //   var response = await apiService.getResponse(
  //     Urls.interest,
  //   );
  //   Map<String, dynamic> responseData =
  //       json.decode(utf8.decode(response.bodyBytes));
  //   ;
  //   return responseData;
  // }
}

import 'dart:convert';
import 'dart:math';

import 'package:machinetestnoviindus/apiservice/webservice.dart';
import 'package:machinetestnoviindus/constants/urls.dart';

class HomeRepo {
  ApiService apiService = ApiService();

  Future<Map<String, dynamic>> categorylist() async {
    var response = await apiService.getResponse(
      Urls.HOME,
    );
    Map<String, dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));
    ;
    // log(response);
    return responseData;
  }
  
  Future<Map<String, dynamic>> homedata() async {
    var response = await apiService.getResponse(
      Urls.CATEGORY_LIST,
    );
    Map<String, dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));
    ;
    // log(response);
    return responseData;
  }
}

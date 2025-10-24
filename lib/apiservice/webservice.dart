import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:machinetestnoviindus/apiservice/baseservice.dart';
import 'package:machinetestnoviindus/apiservice/customheader.dart';
import 'package:machinetestnoviindus/constants/urls.dart';

class ApiService extends BaseService {
  @override
  Future<http.Response> getResponse(String url) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (!url.contains("categoryList")) {
        final tokenHeaders = await CustomHeaders().getHeaders();
        if (tokenHeaders.containsKey("Authorization")) {
          headers["Authorization"] = tokenHeaders["Authorization"]!;
        }
      }

      final response = await http.get(
        Uri.parse(Urls.BASE_URL + url),
        headers: headers,
      );
      log(url);
      return response;
    } catch (e) {
      debugPrint("GET request failed: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> getResponseDirect(
      String url, Map<String, String> headers) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      return response;
    } catch (e) {
      debugPrint("GET direct request failed: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> postResponse(String url, dynamic body) async {
    try {
      final headers = await CustomHeaders().getHeaders();
      log("POST headers: $headers");
      final response = await http.post(
        Uri.parse(Urls.BASE_URL + url),
        headers: headers,
        body: body,
      );
      return response;
    } catch (e) {
      debugPrint("POST request failed: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> putResponse(String url, dynamic body) async {
    try {
      final headers = await CustomHeaders().getHeaders();
      final response = await http.put(
        Uri.parse(Urls.BASE_URL + url),
        headers: headers,
        body: body,
      );
      return response;
    } catch (e) {
      debugPrint("PUT request failed: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteResponse(String url, dynamic body) async {
    try {
      final headers = await CustomHeaders().getHeaders();
      final response = await http.delete(
        Uri.parse(Urls.BASE_URL + url),
        headers: headers,
        body: body,
      );
      return response;
    } catch (e) {
      debugPrint("DELETE request failed: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> patchResponse(String url, dynamic body) async {
    try {
      final headers = await CustomHeaders().getHeaders();
      final response = await http.patch(
        Uri.parse(Urls.BASE_URL + url),
        headers: headers,
        body: body,
      );
      return response;
    } catch (e) {
      debugPrint("PATCH request failed: $e");
      rethrow;
    }
  }
}

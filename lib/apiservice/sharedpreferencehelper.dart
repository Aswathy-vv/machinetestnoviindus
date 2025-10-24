import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Function to save String or Map<String, dynamic> data to SharedPreferences

  static Future<void> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is Map) {
      // JSON encode any map, regardless of value types
      await prefs.setString(key, jsonEncode(value));
    } else {
      throw Exception("Unsupported type for SharedPreferences");
    }
  }

  static Future<void> clearMapList({String key = "recent"}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> addMapToList(Map<String, dynamic> value,
      {String key = "recent"}) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the existing list or use an empty list if not found
    List<String> currentList = prefs.getStringList(key) ?? [];

    // Convert JSON strings to maps
    List<Map<String, dynamic>> currentMapList = currentList
        .map((e) => Map<String, dynamic>.from(jsonDecode(e)))
        .toList();

    // Remove existing item with the same "name"
    currentMapList.removeWhere((map) => map["name"] == value["name"]);

    // Add the new item at the beginning
    currentMapList.insert(0, value);

    // Save updated list
    List<String> updatedList =
        currentMapList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(key, updatedList);
  }

  static Future<List<Map<String, dynamic>>> getMapList(
      {String key = "recent"}) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the list of strings and convert it into a list of maps
    List<String> currentList = prefs.getStringList(key) ?? [];
    return currentList
        .map((e) => Map<String, dynamic>.from(jsonDecode(e)))
        .toList();
  }

  static Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value != null) {
      try {
        return jsonDecode(value);
      } catch (e) {
        return value;
      }
    }
    return null;
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static clearData() async {
    final data = await SharedPreferences.getInstance();
    await data.clear();
  }

  static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<Map<String, String>> getHeaders() async {
    var loginData = await getData("loginData");
    log("login data is $loginData");

    if (loginData == null || loginData["token"] == null) {
      return {"Content-type": "application/json"};
    } else {
      return {
        "Content-type": "application/json",
        "Authorization": "Bearer ${loginData["token"]}",
      };
    }
  }

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }
}

// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPrefrance;

  static init() async {
    sharedPrefrance = await SharedPreferences.getInstance();
  }

  static Future<bool?> SaveData(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPrefrance?.setBool(key, value);
    } else if (value is String) {
      return await sharedPrefrance?.setString(key, value);
    } else if (value is int) {
      return await sharedPrefrance?.setInt(key, value);
    } else
      return await sharedPrefrance?.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPrefrance?.get(key);
  }

  static Future<bool?> removeData({required String key}) async {
    return await sharedPrefrance?.remove(key);
  }
}

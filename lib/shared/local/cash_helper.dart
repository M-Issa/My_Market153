import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //for put isDark status in cash
  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

// for get isDark status in cash
  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences.getBool(key);
  }

  //for set onBoarding and login and others info in cash
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

//for get onBoarding and login and others info from cash
  static dynamic getData({
    required String key,
  }) {
    print(key);
    return sharedPreferences.get(key);
  }

  static Future<bool> clearData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}

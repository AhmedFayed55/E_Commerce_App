import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic val}) {
    if (val is int) {
      return sharedPreferences.setInt(key, val);
    } else if (val is double) {
      return sharedPreferences.setDouble(key, val);
    } else if (val is String) {
      return sharedPreferences.setString(key, val);
    } else {
      return sharedPreferences.setBool(key, val);
    }
  }

  static Object? getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}

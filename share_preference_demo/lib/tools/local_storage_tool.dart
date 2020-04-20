import 'package:shared_preferences/shared_preferences.dart';

class JRLocalStorage {
  // 存储
  static save(String key, dynamic value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  // 读取
  static Future<String> get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}

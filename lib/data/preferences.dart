import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static saveString(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static saveInt(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
}

abstract class PreferencesConstants {
  static const String NEWS_KEYWORD = "keyword";
  static const String NEWS_LAN = "language";
  static const String NEWS_PAGESIZE = "pagesize";
  static const String NEWS_COUNTRY = "country";
}

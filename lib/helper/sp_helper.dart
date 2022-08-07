import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  Future<void> saveString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  Future<void> saveBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  Future<void> saveDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble(key, value);
  }

  Future<String?> loadString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(key) != null &&
        preferences.getString(key)!.isNotEmpty) {
      String? value = preferences.getString(key);
      return value;
    }
    return null;
  }

  Future<int?> loadInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getInt(key) != null) {
      int? value = preferences.getInt(key);
      return value;
    }
    return null;
  }

  Future<double?> loadDouble(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getDouble("weight"));
    return preferences.getDouble(key);

    // return null;
  }

  Future<bool?> loadBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(key) != null) {
      bool? value = preferences.getBool(key);
      return value;
    }
    return null;
  }

  Future<bool?> loadIsActive(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(key) != null) {
      bool? rt = preferences.getBool(key);
      return rt;
    } else {
      return true;
    }
  }
}

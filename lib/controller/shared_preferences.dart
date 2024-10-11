import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void storeData(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
    print("Data Stored Successfully!");
  }

  Future<String> getData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  Future<void> deleteData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  Future<void> storeNewUser(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("newUser", value);
  }

  Future<bool> getNewUser() async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.getBool("newUser") ?? false;
  }
}

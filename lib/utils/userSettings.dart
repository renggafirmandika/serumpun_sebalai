import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static const String _flagTutorial = "flagtutorial";

  static Future<String> getFlagTutorial() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_flagTutorial) ?? "";
  }

  static Future<bool> setFlagTutorial(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_flagTutorial, value);
  }
}

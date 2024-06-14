import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String themeKey = "theme";

  Future<void> saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, isDarkTheme);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';

  // fungsi untuk menyimpan dan membaca data dari shared preferences.
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  // fungsi untuk menyimpan dan membaca data dari shared preferences.
  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }
}
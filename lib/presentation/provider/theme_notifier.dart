import 'package:flutter/material.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/data/datasources/preferences/preferences_helper.dart';

class ThemeNotifier extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  ThemeNotifier({required this.preferencesHelper}) {
    _getTheme();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }
}

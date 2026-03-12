import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, pink, green, blue }

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'app_theme';
  AppTheme _currentTheme = AppTheme.light;

  AppTheme get currentTheme => _currentTheme;

  ThemeService() {
    _loadTheme();
  }

  void setTheme(AppTheme theme) async {
    _currentTheme = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, theme.index);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);
    if (themeIndex != null && themeIndex < AppTheme.values.length) {
      _currentTheme = AppTheme.values[themeIndex];
      notifyListeners();
    }
  }

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppTheme.dark:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple,
        );
      case AppTheme.pink:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            primary: Colors.pinkAccent,
            onPrimary: Colors.white,
            secondary: Colors.pink.shade200,
            surface: Colors.pink.shade50,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
            ),
          ),
        );
      case AppTheme.green:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            primary: Colors.green.shade700,
            onPrimary: Colors.white,
            secondary: Colors.green.shade300,
            surface: Colors.green.shade50,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        );
      case AppTheme.blue:
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue.shade800,
            onPrimary: Colors.white,
            secondary: Colors.blue.shade400,
            surface: Colors.blue.shade50,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
            ),
          ),
        );
      case AppTheme.light:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.orange,
        );
    }
  }
}

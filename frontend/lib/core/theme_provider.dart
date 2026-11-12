import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = 'themeMode';
  ThemeMode _themeMode = ThemeMode.system;

  // Public getter für den ThemeMode
  ThemeMode get themeMode => _themeMode;

  // Public getter für theme = darkmode
  bool get isDark => _themeMode == ThemeMode.dark;

  /// Läd das bisherige Theme aus den lokal gespeicherten Dateien
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved != null) {
      _themeMode = ThemeMode.values.byName(saved);
      notifyListeners();
    }
  }

  /// Setzt das neue Theme. Updated das UI. Speichert das Theme in den lokal gespeicherten Dateien.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;

    notifyListeners(); // UI sofort aktualisieren

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }
}

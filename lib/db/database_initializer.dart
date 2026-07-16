import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseInitializer {
  DatabaseInitializer._();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      await SharedPreferences.getInstance();
      _initialized = true;
    } catch (e) {
      debugPrint('SharedPreferences initialization failed: $e');
      rethrow;
    }
  }
}

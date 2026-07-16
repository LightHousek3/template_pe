import 'package:flutter/foundation.dart';

import 'app_database.dart';

class DatabaseInitializer {
  DatabaseInitializer._();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      await AppDatabase.instance.createSchema();
      _initialized = true;
    } catch (e) {
      debugPrint('Drift initialization failed: $e');
      rethrow;
    }
  }
}

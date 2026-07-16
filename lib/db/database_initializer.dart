import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_database.dart';

class DatabaseInitializer {
  DatabaseInitializer._();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Hive.initFlutter();
      await AppDatabase.instance.usersBox;
      await AppDatabase.instance.artworksBox;
      await AppDatabase.instance.countersBox;
      _initialized = true;
    } catch (e) {
      debugPrint('Hive initialization failed: $e');
      rethrow;
    }
  }
}

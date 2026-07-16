import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseInitializer {
  DatabaseInitializer._();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      if (kIsWeb) {
        throw UnsupportedError('sqflite is not supported on Flutter Web.');
      }

      if (_isDesktop) {
        debugPrint('Desktop platform detected.');
        debugPrint('Initializing SQLite FFI...');

        sqfliteFfiInit();

        debugPrint('SQLite FFI initialized.');
      } else {
        debugPrint('Using native sqflite.');
      }

      _initialized = true;
    } catch (e) {
      debugPrint('Database initialization failed: $e');

      rethrow;
    }
  }

  static bool get _isDesktop =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

class DatabaseFactoryProvider {
  DatabaseFactoryProvider._();

  static sqflite.DatabaseFactory get instance {
    if (kIsWeb) {
      throw UnsupportedError('sqflite is not supported on Flutter Web.');
    }

    if (_isDesktop) {
      return ffi.databaseFactoryFfi;
    }

    return sqflite.databaseFactory;
  }

  static bool get _isDesktop =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase extends GeneratedDatabase {
  AppDatabase._() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._();

  @override
  int get schemaVersion => 1;

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => const [];

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => const [];

  Future<void> createSchema() async {
    await customStatement('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS artworks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        artist TEXT NOT NULL,
        year TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        completed INTEGER NOT NULL DEFAULT 0,
        createdBy INTEGER NOT NULL,
        FOREIGN KEY(createdBy) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> deleteDatabaseFile() async {
    await close();
    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, 'art_gallery_manager_drift.db'));
    if (await file.exists()) {
      await file.delete();
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, 'art_gallery_manager_drift.db'));
    return NativeDatabase.createInBackground(file);
  });
}

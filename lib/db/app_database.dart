import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_factory_provider.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _dbName = 'art_gallery_manager.db';
  static const int _dbVersion = 3;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();

    return _database!;
  }

  Future<Database> _openDatabase() async {
    final factory = DatabaseFactoryProvider.instance;

    final dbPath = await factory.getDatabasesPath();

    final path = join(dbPath, _dbName);

    return await factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: _dbVersion,

        onConfigure: (db) async {
          // Enable Foreign Key
          await db.execute('PRAGMA foreign_keys = ON');
        },

        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE users(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              username TEXT NOT NULL UNIQUE,
              email TEXT NOT NULL,
              password TEXT NOT NULL,
              createdAt TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE artworks(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              artist TEXT NOT NULL,
              year TEXT NOT NULL,
              category TEXT NOT NULL,
              description TEXT NOT NULL,
              completed INTEGER NOT NULL DEFAULT 0,
              favorite INTEGER NOT NULL DEFAULT 0,
              createdBy INTEGER NOT NULL,
              FOREIGN KEY(createdBy) REFERENCES users(id) ON DELETE CASCADE
            )
          ''');
        },

        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute(
              'ALTER TABLE artworks ADD COLUMN completed INTEGER NOT NULL DEFAULT 0',
            );
          }
          if (oldVersion < 3) {
            await db.execute(
              'ALTER TABLE artworks ADD COLUMN favorite INTEGER NOT NULL DEFAULT 0',
            );
          }
        },

        onDowngrade: onDatabaseDowngradeDelete,
      ),
    );
  }

  Future<void> close() async {
    await _database?.close();

    _database = null;
  }

  Future<void> deleteDatabaseFile() async {
    final factory = DatabaseFactoryProvider.instance;

    final dbPath = await factory.getDatabasesPath();

    final path = join(dbPath, _dbName);

    await close();

    await factory.deleteDatabase(path);
  }
}

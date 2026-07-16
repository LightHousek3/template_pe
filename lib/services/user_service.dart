import 'package:sqflite/sqflite.dart';

import '../db/app_database.dart';
import '../models/user.dart';

class UserService {
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return User.fromMap(rows.first);
  }

  Future<bool> isUsernameTaken(String username) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      'users',
      columns: ['id'],
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    return rows.isNotEmpty;
  }

  Future<int> register(User user) async {
    final db = await AppDatabase.instance.database;

    try {
      return await db.insert('users', user.toMap());
    } on DatabaseException catch (error) {
      if (error.isUniqueConstraintError()) {
        throw const UserServiceException('Username already exists');
      }

      rethrow;
    }
  }
}

class UserServiceException implements Exception {
  const UserServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

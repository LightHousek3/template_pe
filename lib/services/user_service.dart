import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/user.dart';

class UserService {
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final rows = await AppDatabase.instance
        .customSelect(
          'SELECT * FROM users WHERE username = ? AND password = ? LIMIT 1',
          variables: [
            Variable.withString(username),
            Variable.withString(password),
          ],
          readsFrom: const {},
        )
        .get();

    if (rows.isEmpty) return null;
    return User.fromMap(rows.first.data);
  }

  Future<bool> isUsernameTaken(String username) async {
    final rows = await AppDatabase.instance
        .customSelect(
          'SELECT id FROM users WHERE username = ? LIMIT 1',
          variables: [Variable.withString(username)],
          readsFrom: const {},
        )
        .get();

    return rows.isNotEmpty;
  }

  Future<int> register(User user) async {
    if (await isUsernameTaken(user.username)) {
      throw const UserServiceException('Username already exists');
    }

    return AppDatabase.instance.customInsert(
      '''
      INSERT INTO users(username, email, password, createdAt)
      VALUES (?, ?, ?, ?)
      ''',
      variables: [
        Variable.withString(user.username),
        Variable.withString(user.email),
        Variable.withString(user.password),
        Variable.withString(user.createdAt),
      ],
    );
  }
}

class UserServiceException implements Exception {
  const UserServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

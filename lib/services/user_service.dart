import '../db/app_database.dart';
import '../models/user.dart';

class UserService {
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final rows = await AppDatabase.instance.readList(AppDatabase.usersKey);
    for (final row in rows) {
      final user = User.fromMap(row);
      if (user.username == username && user.password == password) {
        return user;
      }
    }

    return null;
  }

  Future<bool> isUsernameTaken(String username) async {
    final rows = await AppDatabase.instance.readList(AppDatabase.usersKey);
    return rows.any((row) => row['username'] == username);
  }

  Future<int> register(User user) async {
    if (await isUsernameTaken(user.username)) {
      throw const UserServiceException('Username already exists');
    }

    final rows = await AppDatabase.instance.readList(AppDatabase.usersKey);
    final id = await AppDatabase.instance.nextId(AppDatabase.userCounterKey);
    rows.add(user.copyWith(id: id).toMap());
    await AppDatabase.instance.writeList(AppDatabase.usersKey, rows);
    return id;
  }
}

class UserServiceException implements Exception {
  const UserServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

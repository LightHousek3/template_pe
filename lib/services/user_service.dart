import '../db/app_database.dart';
import '../models/user.dart';

class UserService {
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final box = await AppDatabase.instance.usersBox;
    for (final value in box.values) {
      final user = User.fromMap(Map<String, Object?>.from(value as Map));
      if (user.username == username && user.password == password) {
        return user;
      }
    }

    return null;
  }

  Future<bool> isUsernameTaken(String username) async {
    final box = await AppDatabase.instance.usersBox;
    return box.values.any((value) {
      final user = User.fromMap(Map<String, Object?>.from(value as Map));
      return user.username == username;
    });
  }

  Future<int> register(User user) async {
    if (await isUsernameTaken(user.username)) {
      throw const UserServiceException('Username already exists');
    }

    final box = await AppDatabase.instance.usersBox;
    final id = await AppDatabase.instance.nextId('users');
    await box.put(id, user.copyWith(id: id).toMap());
    return id;
  }
}

class UserServiceException implements Exception {
  const UserServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

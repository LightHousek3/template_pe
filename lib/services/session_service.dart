import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _userIdKey = 'session_user_id';
  static const _usernameKey = 'session_username';

  Future<void> saveSession({
    required int userId,
    required String username,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_userIdKey, userId);
    await preferences.setString(_usernameKey, username);
  }

  Future<int?> getUserId() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_userIdKey);
  }

  Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }

  Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_userIdKey);
    await preferences.remove(_usernameKey);
  }
}

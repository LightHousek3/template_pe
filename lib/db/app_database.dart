import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const usersKey = 'db_users';
  static const artworksKey = 'db_artworks';
  static const userCounterKey = 'db_user_counter';
  static const artworkCounterKey = 'db_artwork_counter';

  Future<List<Map<String, Object?>>> readList(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final rawValue = preferences.getString(key);
    if (rawValue == null || rawValue.isEmpty) return [];

    final values = jsonDecode(rawValue) as List<dynamic>;
    return values
        .map((value) => Map<String, Object?>.from(value as Map))
        .toList();
  }

  Future<void> writeList(String key, List<Map<String, Object?>> values) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, jsonEncode(values));
  }

  Future<int> nextId(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final nextValue = (preferences.getInt(key) ?? 0) + 1;
    await preferences.setInt(key, nextValue);
    return nextValue;
  }

  Future<void> close() async {}

  Future<void> deleteDatabaseFile() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(usersKey);
    await preferences.remove(artworksKey);
    await preferences.remove(userCounterKey);
    await preferences.remove(artworkCounterKey);
  }
}

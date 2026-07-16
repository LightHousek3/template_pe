import 'package:hive/hive.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const usersBoxName = 'users';
  static const artworksBoxName = 'artworks';
  static const countersBoxName = 'counters';

  Future<Box> get usersBox => Hive.openBox(usersBoxName);
  Future<Box> get artworksBox => Hive.openBox(artworksBoxName);
  Future<Box<int>> get countersBox => Hive.openBox<int>(countersBoxName);

  Future<int> nextId(String counterKey) async {
    final box = await countersBox;
    final nextValue = (box.get(counterKey) ?? 0) + 1;
    await box.put(counterKey, nextValue);
    return nextValue;
  }

  Future<void> close() async {
    await Hive.close();
  }

  Future<void> deleteDatabaseFile() async {
    await close();
    await Hive.deleteBoxFromDisk(usersBoxName);
    await Hive.deleteBoxFromDisk(artworksBoxName);
    await Hive.deleteBoxFromDisk(countersBoxName);
  }
}

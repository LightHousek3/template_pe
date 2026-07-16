import '../db/app_database.dart';
import '../models/artwork.dart';

class AppService {
  static final table = 'artworks';

  Future<List<Artwork>> findByUser(
    int userId, {
    String searchText = '',
    String? category,
    bool? completed,
  }) async {
    final db = await AppDatabase.instance.database;
    final whereParts = <String>['createdBy = ?'];
    final whereArgs = <Object?>[userId];
    final keyword = searchText.trim();

    if (keyword.isNotEmpty) {
      whereParts.add('(LOWER(title) LIKE ? OR LOWER(category) LIKE ?)');
      final like = '%${keyword.toLowerCase()}%';
      whereArgs.addAll([like, like]);
    }

    if (category != null && category.isNotEmpty) {
      whereParts.add('category = ?');
      whereArgs.add(category);
    }

    if (completed != null) {
      whereParts.add('completed = ?');
      whereArgs.add(completed ? 1 : 0);
    }

    final rows = await db.query(
      table,
      where: whereParts.join(' AND '),
      whereArgs: whereArgs,
      orderBy: 'id DESC',
    );

    return rows.map(Artwork.fromMap).toList();
  }

  Future<int> add(Artwork artwork) async {
    final db = await AppDatabase.instance.database;
    return db.insert(table, artwork.toMap());
  }

  Future<void> update(Artwork artwork) async {
    if (artwork.id == null) return;

    final db = await AppDatabase.instance.database;
    await db.update(
      table,
      artwork.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [artwork.id],
    );
  }

  Future<void> toggleCompleted(Artwork artwork) async {
    await update(artwork.copyWith(completed: !artwork.completed));
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}

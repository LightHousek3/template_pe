import '../config/entity_config.dart';
import '../db/app_database.dart';
import '../models/artwork.dart';
import '../models/data_summary.dart';

class AppService {
  static final table = 'artworks';

  Future<List<Artwork>> findByUser(
    int userId, {
    String searchText = '',
    String? category,
    String yearFilter = EntityConfig.yearFilterAll,
    bool? completed,
    bool? favorite,
  }) async {
    final db = await AppDatabase.instance.database;
    final whereParts = <String>['createdBy = ?'];
    final whereArgs = <Object?>[userId];
    final keyword = searchText.trim();

    if (keyword.isNotEmpty) {
      // Lab1 search theo Title. Neu de yeu cau search field khac, sua dieu kien nay.
      whereParts.add('LOWER(title) LIKE ?');
      final like = '%${keyword.toLowerCase()}%';
      whereArgs.add(like);
    }

    if (category != null && category.isNotEmpty) {
      whereParts.add('category = ?');
      whereArgs.add(category);
    }

    final yearWhere = _buildYearWhere(yearFilter);
    if (yearWhere != null) {
      whereParts.add(yearWhere.where);
      whereArgs.addAll(yearWhere.args);
    }

    if (completed != null) {
      whereParts.add('completed = ?');
      whereArgs.add(completed ? 1 : 0);
    }

    if (favorite != null) {
      whereParts.add('favorite = ?');
      whereArgs.add(favorite ? 1 : 0);
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

  Future<void> toggleFavorite(Artwork artwork) async {
    await update(artwork.copyWith(favorite: !artwork.favorite));
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<DataSummary> getSummary(int userId) async {
    final items = await findByUser(userId);
    return DataSummary(
      totalItems: items.length,
      favoriteItems: items.where((item) => item.favorite).length,
      completedItems: items.where((item) => item.completed).length,
      categoryCount: items.map((item) => item.category).toSet().length,
    );
  }

  _YearWhere? _buildYearWhere(String yearFilter) {
    final currentYear = DateTime.now().year;

    if (yearFilter == EntityConfig.yearFilterCurrent) {
      return _YearWhere('year = ?', [currentYear.toString()]);
    }

    if (yearFilter == EntityConfig.yearFilterRecent) {
      return _YearWhere('CAST(year AS INTEGER) >= ?', [currentYear - 5]);
    }

    return null;
  }
}

class _YearWhere {
  const _YearWhere(this.where, this.args);

  final String where;
  final List<Object?> args;
}

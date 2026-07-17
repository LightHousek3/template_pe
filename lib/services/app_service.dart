import 'package:drift/drift.dart';

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
    final whereParts = <String>['createdBy = ?'];
    final variables = <Variable>[Variable.withInt(userId)];
    final keyword = searchText.trim();

    if (keyword.isNotEmpty) {
      // Lab1 search theo Title. Neu de yeu cau search field khac, sua dieu kien nay.
      whereParts.add('LOWER(title) LIKE ?');
      variables.add(Variable.withString('%${keyword.toLowerCase()}%'));
    }

    if (category != null && category.isNotEmpty) {
      whereParts.add('category = ?');
      variables.add(Variable.withString(category));
    }

    final yearWhere = _buildYearWhere(yearFilter);
    if (yearWhere != null) {
      whereParts.add(yearWhere.where);
      variables.addAll(yearWhere.variables);
    }

    if (completed != null) {
      whereParts.add('completed = ?');
      variables.add(Variable.withInt(completed ? 1 : 0));
    }

    if (favorite != null) {
      whereParts.add('favorite = ?');
      variables.add(Variable.withInt(favorite ? 1 : 0));
    }

    final rows = await AppDatabase.instance
        .customSelect(
          'SELECT * FROM $table WHERE ${whereParts.join(' AND ')} ORDER BY id DESC',
          variables: variables,
          readsFrom: const {},
        )
        .get();

    return rows.map((row) => Artwork.fromMap(row.data)).toList();
  }

  Future<int> add(Artwork artwork) async {
    return AppDatabase.instance.customInsert(
      '''
      INSERT INTO $table(title, artist, year, category, description, completed, favorite, createdBy)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''',
      variables: [
        Variable.withString(artwork.title),
        Variable.withString(artwork.artist),
        Variable.withString(artwork.year),
        Variable.withString(artwork.category),
        Variable.withString(artwork.description),
        Variable.withInt(artwork.completed ? 1 : 0),
        Variable.withInt(artwork.favorite ? 1 : 0),
        Variable.withInt(artwork.createdBy),
      ],
    );
  }

  Future<void> update(Artwork artwork) async {
    if (artwork.id == null) return;

    await AppDatabase.instance.customUpdate(
      '''
      UPDATE $table
      SET title = ?, artist = ?, year = ?, category = ?, description = ?, completed = ?, favorite = ?, createdBy = ?
      WHERE id = ?
      ''',
      variables: [
        Variable.withString(artwork.title),
        Variable.withString(artwork.artist),
        Variable.withString(artwork.year),
        Variable.withString(artwork.category),
        Variable.withString(artwork.description),
        Variable.withInt(artwork.completed ? 1 : 0),
        Variable.withInt(artwork.favorite ? 1 : 0),
        Variable.withInt(artwork.createdBy),
        Variable.withInt(artwork.id!),
      ],
    );
  }

  Future<void> toggleCompleted(Artwork artwork) async {
    await update(artwork.copyWith(completed: !artwork.completed));
  }

  Future<void> toggleFavorite(Artwork artwork) async {
    await update(artwork.copyWith(favorite: !artwork.favorite));
  }

  Future<void> delete(int id) async {
    await AppDatabase.instance.customUpdate(
      'DELETE FROM $table WHERE id = ?',
      variables: [Variable.withInt(id)],
    );
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
      return _YearWhere('year = ?', [Variable.withString('$currentYear')]);
    }

    if (yearFilter == EntityConfig.yearFilterRecent) {
      return _YearWhere('CAST(year AS INTEGER) >= ?', [
        Variable.withInt(currentYear - 5),
      ]);
    }

    return null;
  }
}

class _YearWhere {
  const _YearWhere(this.where, this.variables);

  final String where;
  final List<Variable> variables;
}

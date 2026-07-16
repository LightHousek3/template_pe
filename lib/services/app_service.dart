import 'package:drift/drift.dart';

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
    final whereParts = <String>['createdBy = ?'];
    final variables = <Variable>[Variable.withInt(userId)];
    final keyword = searchText.trim();

    if (keyword.isNotEmpty) {
      whereParts.add('(LOWER(title) LIKE ? OR LOWER(category) LIKE ?)');
      final like = '%${keyword.toLowerCase()}%';
      variables.addAll([Variable.withString(like), Variable.withString(like)]);
    }

    if (category != null && category.isNotEmpty) {
      whereParts.add('category = ?');
      variables.add(Variable.withString(category));
    }

    if (completed != null) {
      whereParts.add('completed = ?');
      variables.add(Variable.withInt(completed ? 1 : 0));
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
      INSERT INTO $table(title, artist, year, category, description, completed, createdBy)
      VALUES (?, ?, ?, ?, ?, ?, ?)
      ''',
      variables: [
        Variable.withString(artwork.title),
        Variable.withString(artwork.artist),
        Variable.withString(artwork.year),
        Variable.withString(artwork.category),
        Variable.withString(artwork.description),
        Variable.withInt(artwork.completed ? 1 : 0),
        Variable.withInt(artwork.createdBy),
      ],
    );
  }

  Future<void> update(Artwork artwork) async {
    if (artwork.id == null) return;

    await AppDatabase.instance.customUpdate(
      '''
      UPDATE $table
      SET title = ?, artist = ?, year = ?, category = ?, description = ?, completed = ?, createdBy = ?
      WHERE id = ?
      ''',
      variables: [
        Variable.withString(artwork.title),
        Variable.withString(artwork.artist),
        Variable.withString(artwork.year),
        Variable.withString(artwork.category),
        Variable.withString(artwork.description),
        Variable.withInt(artwork.completed ? 1 : 0),
        Variable.withInt(artwork.createdBy),
        Variable.withInt(artwork.id!),
      ],
    );
  }

  Future<void> toggleCompleted(Artwork artwork) async {
    await update(artwork.copyWith(completed: !artwork.completed));
  }

  Future<void> delete(int id) async {
    await AppDatabase.instance.customUpdate(
      'DELETE FROM $table WHERE id = ?',
      variables: [Variable.withInt(id)],
    );
  }
}

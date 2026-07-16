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
    final keyword = searchText.trim();
    final box = await AppDatabase.instance.artworksBox;
    final rows = box.values
        .map((value) => Map<String, Object?>.from(value as Map))
        .map(Artwork.fromMap)
        .where((artwork) => artwork.createdBy == userId)
        .where((artwork) {
          if (keyword.isEmpty) return true;
          final normalizedKeyword = keyword.toLowerCase();
          return artwork.title.toLowerCase().contains(normalizedKeyword) ||
              artwork.category.toLowerCase().contains(normalizedKeyword);
        })
        .where((artwork) => category == null || artwork.category == category)
        .where((artwork) => completed == null || artwork.completed == completed)
        .toList()
      ..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));

    return rows;
  }

  Future<int> add(Artwork artwork) async {
    final box = await AppDatabase.instance.artworksBox;
    final id = await AppDatabase.instance.nextId(table);
    await box.put(id, artwork.copyWith(id: id).toMap());
    return id;
  }

  Future<void> update(Artwork artwork) async {
    if (artwork.id == null) return;

    final box = await AppDatabase.instance.artworksBox;
    await box.put(artwork.id, artwork.toMap());
  }

  Future<void> toggleCompleted(Artwork artwork) async {
    await update(artwork.copyWith(completed: !artwork.completed));
  }

  Future<void> delete(int id) async {
    final box = await AppDatabase.instance.artworksBox;
    await box.delete(id);
  }
}

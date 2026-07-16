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
    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    final artworks = rows
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

    return artworks;
  }

  Future<int> add(Artwork artwork) async {
    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    final id = await AppDatabase.instance.nextId(
      AppDatabase.artworkCounterKey,
    );
    rows.add(artwork.copyWith(id: id).toMap());
    await AppDatabase.instance.writeList(AppDatabase.artworksKey, rows);
    return id;
  }

  Future<void> update(Artwork artwork) async {
    if (artwork.id == null) return;

    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    final index = rows.indexWhere((row) => row['id'] == artwork.id);
    if (index == -1) return;

    rows[index] = artwork.toMap();
    await AppDatabase.instance.writeList(AppDatabase.artworksKey, rows);
  }

  Future<void> toggleCompleted(Artwork artwork) async {
    await update(artwork.copyWith(completed: !artwork.completed));
  }

  Future<void> delete(int id) async {
    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    rows.removeWhere((row) => row['id'] == id);
    await AppDatabase.instance.writeList(AppDatabase.artworksKey, rows);
  }
}

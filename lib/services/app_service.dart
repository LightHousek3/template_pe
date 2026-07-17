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
    final keyword = searchText.trim().toLowerCase();
    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    final items =
        rows
            .map(Artwork.fromMap)
            .where((item) => item.createdBy == userId)
            .where((item) {
              // Lab1 search theo Title. Neu de yeu cau search field khac, sua dieu kien nay.
              return keyword.isEmpty ||
                  item.title.toLowerCase().contains(keyword);
            })
            .where((item) => category == null || item.category == category)
            .where((item) => _matchesYearFilter(item.year, yearFilter))
            .where((item) => completed == null || item.completed == completed)
            .where((item) => favorite == null || item.favorite == favorite)
            .toList()
          ..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));

    return items;
  }

  Future<int> add(Artwork artwork) async {
    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    final id = await AppDatabase.instance.nextId(AppDatabase.artworkCounterKey);
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

  Future<void> toggleFavorite(Artwork artwork) async {
    await update(artwork.copyWith(favorite: !artwork.favorite));
  }

  Future<void> delete(int id) async {
    final rows = await AppDatabase.instance.readList(AppDatabase.artworksKey);
    rows.removeWhere((row) => row['id'] == id);
    await AppDatabase.instance.writeList(AppDatabase.artworksKey, rows);
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

  bool _matchesYearFilter(String year, String yearFilter) {
    final parsedYear = int.tryParse(year);
    final currentYear = DateTime.now().year;

    if (yearFilter == EntityConfig.yearFilterCurrent) {
      return parsedYear == currentYear;
    }

    if (yearFilter == EntityConfig.yearFilterRecent) {
      return parsedYear != null && parsedYear >= currentYear - 5;
    }

    return true;
  }
}

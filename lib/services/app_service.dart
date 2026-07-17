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
    final box = await AppDatabase.instance.artworksBox;
    final rows =
        box.values
            .map((value) => Map<String, Object?>.from(value as Map))
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

  Future<void> toggleFavorite(Artwork artwork) async {
    await update(artwork.copyWith(favorite: !artwork.favorite));
  }

  Future<void> delete(int id) async {
    final box = await AppDatabase.instance.artworksBox;
    await box.delete(id);
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

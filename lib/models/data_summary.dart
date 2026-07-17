class DataSummary {
  const DataSummary({
    required this.totalItems,
    required this.favoriteItems,
    required this.completedItems,
    required this.categoryCount,
  });

  final int totalItems;
  final int favoriteItems;
  final int completedItems;
  final int categoryCount;
}

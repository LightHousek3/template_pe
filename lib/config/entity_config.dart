class EntityConfig {
  EntityConfig._();

  // DOI NHANH KHI DI THI:
  // Lab1: Artwork / Artworks
  // Lab4: Bill / Bills
  // Lab5: Item / Items
  static const entityName = 'Artwork';
  static const entityNamePlural = 'Artworks';

  // DOI NHANH THEO DE:
  // Lab1: Abstract, Realism, Landscape, Portrait
  // Lab4: Utilities, Subscription, Rent, Finance, Health
  // Lab5: Fashion, Electronics, Home
  static const categories = ['Abstract', 'Realism', 'Landscape', 'Portrait'];

  static const yearFilterAll = 'All years';
  static const yearFilterCurrent = 'Current year';
  static const yearFilterRecent = 'Last 5 years';

  static const yearFilters = [
    yearFilterAll,
    yearFilterCurrent,
    yearFilterRecent,
  ];

  static const statusOnLabel = 'Completed';
  static const statusOffLabel = 'In progress';
  static const favoriteLabel = 'Favorite';
}

class Artwork {
  const Artwork({
    this.id,
    required this.title,
    required this.artist,
    required this.year,
    required this.category,
    required this.description,
    required this.createdBy,
    this.completed = false,
    this.favorite = false,
  });

  final int? id;
  final String title;
  final String artist;
  final String year;
  final String category;
  final String description;
  final int createdBy;
  final bool completed;
  final bool favorite;

  Artwork copyWith({
    int? id,
    String? title,
    String? artist,
    String? year,
    String? category,
    String? description,
    int? createdBy,
    bool? completed,
    bool? favorite,
  }) {
    return Artwork(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      year: year ?? this.year,
      category: category ?? this.category,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      completed: completed ?? this.completed,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'year': year,
      'category': category,
      'description': description,
      'createdBy': createdBy,
      'completed': completed ? 1 : 0,
      'favorite': favorite ? 1 : 0,
    };
  }

  factory Artwork.fromMap(Map<String, Object?> map) {
    return Artwork(
      id: map['id'] as int?,
      title: map['title'] as String,
      artist: map['artist'] as String,
      year: map['year'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      createdBy: map['createdBy'] as int,
      completed: (map['completed'] as int? ?? 0) == 1,
      favorite: (map['favorite'] as int? ?? 0) == 1,
    );
  }
}

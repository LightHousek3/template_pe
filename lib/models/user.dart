class User {
  const User({
    this.id,
    required this.username,
    required this.age,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  final int? id;
  final String username;
  final int age;
  final String email;
  final String password;
  final String createdAt;

  User copyWith({
    int? id,
    String? username,
    int? age,
    String? email,
    String? password,
    String? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      age: age ?? this.age,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'age': age,
      'email': email,
      'password': password,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, Object?> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}

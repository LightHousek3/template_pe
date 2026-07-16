class User {
  const User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  final int? id;
  final String username;
  final String email;
  final String password;
  final String createdAt;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, Object?> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}

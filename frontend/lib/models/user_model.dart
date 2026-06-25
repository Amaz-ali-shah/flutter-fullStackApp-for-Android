class UserModel {
  final String id;
  final String email;
  final String name;
  final String? token;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  // ---- JSON serialization ----
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // ---- copyWith ----
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? token,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ---- Equality & debugging ----
  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, token: $token, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.token == token &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(id, email, name, token, createdAt, updatedAt);
  }
}

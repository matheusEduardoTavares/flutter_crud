import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String login;  
  final String password;
  final DateTime? createdAt;  
  final DateTime? updatedAt;  
  final DateTime? deletedAt;  

  UserModel({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nome': name,
      'login': login,
      'senha': password,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      // id: int.tryParse(map['_id']?.toString() ?? '') ?? 0,
      id: map['_id']?.toString() ?? '',
      name: map['nome'] ?? '',
      login: map['login'] ?? '',
      password: map['senha'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(map['deletedAt']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.login == login &&
      other.password == password &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      login.hashCode ^
      password.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode;
  }
}

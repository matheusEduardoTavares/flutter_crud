import 'dart:convert';

class UserModel {
  final int id;
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
      'id': id,
      'nome': name,
      'login': login,
      'senha': password,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: int.tryParse(map['id'] ?? '') ?? 0,
      name: map['nome'] ?? '',
      login: map['login'] ?? '',
      password: map['senha'] ?? '',
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(map['updated_at']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(map['deleted_at']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}

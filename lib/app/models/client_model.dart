import 'dart:convert';

class Client {
  final int id;
  final String name;
  final String cpf;  
  final String rg;
  final DateTime? createdAt;  
  final DateTime? updatedAt;  
  final DateTime? deletedAt;  

  Client({
    required this.id,
    required this.name,
    required this.cpf,
    required this.rg,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'cpf': cpf,
      'rg': rg,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: int.tryParse(map['id'] ?? '') ?? 0,
      name: map['nome'] ?? '',
      cpf: map['cpf'] ?? '',
      rg: map['rg'] ?? '',
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(map['updated_at']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(map['deleted_at']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source));
}

import 'dart:convert';

class ClientModel {
  final String id;
  final String name;
  final String cpf;  
  final String rg;
  final DateTime? createdAt;  
  final DateTime? updatedAt;  
  final DateTime? deletedAt;  

  ClientModel({
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
      '_id': id,
      'nome': name,
      'cpf': cpf,
      'rg': rg,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      // id: int.tryParse(map['_id']?.toString() ?? '') ?? 0,
      id: map['_id']?.toString() ?? '',
      name: map['nome'] ?? '',
      cpf: map['cpf'] ?? '',
      rg: map['rg'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(map['deletedAt']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source));
}

import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final double stock;  
  final double costPrice;
  final double salePrice;
  final DateTime? createdAt;  
  final DateTime? updatedAt;  
  final DateTime? deletedAt;
  
  ProductModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.costPrice,
    required this.salePrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'estoque': stock,
      'preco_custo': costPrice,
      'preco_venda': salePrice,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      // id: int.tryParse(map['id']?.toString() ?? '') ?? 0,
      id: map['id']?.toString() ?? '',
      name: map['nome'] ?? '',
      stock: double.tryParse(map['estoque']?.toString() ?? '') ?? 0.0,
      costPrice: double.tryParse(map['preco_custo']?.toString() ?? '') ?? 0.0,
      salePrice: double.tryParse(map['preco_venda']?.toString() ?? '') ?? 0.0,
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(map['updated_at']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(map['deleted_at']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}

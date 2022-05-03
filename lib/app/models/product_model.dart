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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
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
      createdAt: DateTime.tryParse(map['createdAt']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(map['deletedAt']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}

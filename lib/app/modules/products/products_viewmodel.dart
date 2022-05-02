import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/core/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter_crud/app/models/product_model.dart';
import 'package:flutter_crud/app/modules/products/products_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductViewmodel {
  ProductViewmodel({
    required ProductRepository repository
  }) : _repository = repository;

  final ProductRepository _repository;

  var isEncrypt = false;

  final _productsController = StreamController<List<ProductModel>>();
  Stream<List<ProductModel>> get productsOut => _productsController.stream;
  Sink<List<ProductModel>> get productsIn => _productsController.sink;

  void orderProduct(String key, bool isAscending, List<Map<String, dynamic>> products) {
    final ordenedProducts = _oderEntity(key, isAscending, products);

    productsIn.add(ordenedProducts.map((e) => ProductModel.fromMap(e)).toList());
  }

  Future<void> updateEntity(Map<String, dynamic> data, BuildContext context) {
    return _upsertEntity(data, context, (productModel) async {
      await _repository.updateProduct(productModel);
    });
  }

  Future<void> createEntity(BuildContext context) {
    return _upsertEntity(
      {}, 
      context, 
      (productModel) async {
        await _repository.createProduct(productModel);
      },
      title: 'Criar'
    );
  }

  Future<void> _upsertEntity(
    Map<String, dynamic> data, 
    BuildContext context, 
    Future<void> Function(ProductModel productModel) upsert, {
      String? title,
    }
  ) async {
    final newData = await Modular.to.pushNamed<Map<String, dynamic>>(
      '${ModulesDefinition.products}${ModulesDefinition.upsertProduct}',
      arguments: {
        'product': data,
        'title': title,
      },
    );

    if (newData != null) {
      await upsert(ProductModel.fromMap(newData));

      await loadData();
    }
  }

  Future<void> deleteEntity(int id, BuildContext context) async {
    final isDelete = await showDialog<bool>(
      context: context, 
      builder: (_) => const ConfirmDialog(),
    );

    if (isDelete != null && isDelete) {
      await _repository.deleteProduct(id);

      await loadData();
    }
  }

  List<Map<String, dynamic>> _oderEntity(String key, bool isAscending, List<Map<String, dynamic>> data) {
    var newList = List<Map<String, dynamic>>.from(data);
    newList.sort((a, b) {
      return a[key].compareTo(b[key]);
    });

    if (!isAscending) {
      newList = newList.reversed.toList();
    }

    return newList;
  }

  Future<void> loadData() async {
    final products = await _repository.loadProducts(
      isEncrypt,
    );
    
    productsIn.add(products);
  }
}
import 'package:flutter_crud/app/core/rest_client/rest_client.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/models/product_model.dart';

class ProductRepository {
  ProductRepository({
    required RestClient restClient
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<List<ProductModel>> loadProducts(bool isEncrypt) async {
    final getProducts = await _restClient.get(
      BackendEndpointsDefinition.products,
      queryParameters: {
        'isEncrypt': isEncrypt,
      }
    );

    return (getProducts.data as List).map((e) => ProductModel.fromMap(e)).toList();
  }  

  Future<void> deleteProduct(String id) async {
    await _restClient.delete(
      '${BackendEndpointsDefinition.products}/$id'
    );
  }  

  Future<void> updateProduct(ProductModel product) async {
    await _restClient.put(
      '${BackendEndpointsDefinition.products}/${product.id}',
      data: product.toMap(),
    );
  }

  Future<void> createProduct(ProductModel product) async {
    await _restClient.post(
      BackendEndpointsDefinition.products,
      data: product.toMap(),
    );
  }
}
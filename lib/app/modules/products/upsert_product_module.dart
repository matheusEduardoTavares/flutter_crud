import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/modules/products/upsert_product/upsert_product_page.dart';
import 'package:flutter_crud/app/modules/products/products_page.dart';
import 'package:flutter_crud/app/modules/products/products_repository.dart';
import 'package:flutter_crud/app/modules/products/products_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductModule extends Module {

   @override
   final List<Bind> binds = [
     Bind.lazySingleton((i) => ProductRepository(restClient: i())),
     Bind.lazySingleton((i) => ProductViewmodel(
       repository: i(),
      ))
   ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, args) => ProductPage(
        viewmodel: Modular.get(),
      )
    ),
    ChildRoute(
      ModulesDefinition.upsertProduct, 
      child: (_, args) => UpsertProductPage(
        productData: args.data['product'],
        title: args.data['title'],
      )
    ),
  ];

}
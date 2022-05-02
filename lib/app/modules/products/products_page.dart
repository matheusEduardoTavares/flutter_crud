import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/core/widgets/list_table/list_table.dart';
import 'package:flutter_crud/app/models/list_table/list_table_definition.dart';
import 'package:flutter_crud/app/models/product_model.dart';
import 'package:flutter_crud/app/modules/products/products_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({ 
    Key? key ,
    required ProductViewmodel viewmodel,
  }) : 
  _viewmodel = viewmodel,
  super(key: key);

  final ProductViewmodel _viewmodel;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();

    widget._viewmodel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de produtos'),
        actions: [
          IconButton(
            icon: Icon(
              widget._viewmodel.isEncrypt ? Icons.enhanced_encryption : Icons.no_encryption
            ),
            onPressed: () {
              setState(() {
                widget._viewmodel.isEncrypt = !widget._viewmodel.isEncrypt;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget._viewmodel.createEntity(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<ProductModel>>(
        initialData: const [],
        stream: widget._viewmodel.productsOut,
        builder: (_, snapshot) => Column(
          children: [
            Expanded(
              child: snapshot.data?.isEmpty ?? true ? const Center(
                child: Text('Não há nenhum produto'),
              ) : ListTable(
                tableDefinition: ListTableDefinition(
                  endpoint: BackendEndpointsDefinition.products,
                  items: snapshot.data!.map((e) => e.toMap()).toList(),
                  entityData: snapshot.data!.isNotEmpty ? 
                    snapshot.data![0].toMap() : {},
                  orderData: widget._viewmodel.orderProduct,
                  deleteEntity: widget._viewmodel.deleteEntity,
                  updateEntity: widget._viewmodel.updateEntity,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Modular.to.navigate(ModulesDefinition.user);
                  }, 
                  child: const Text('Usuários')
                ),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.navigate(ModulesDefinition.clients);
                  }, 
                  child: const Text('Clientes')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/core/widgets/list_table/list_table.dart';
import 'package:flutter_crud/app/models/list_table/list_table_definition.dart';
import 'package:flutter_crud/app/models/client_model.dart';
import 'package:flutter_crud/app/modules/clients/client_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({ 
    Key? key ,
    required ClientViewmodel viewmodel,
  }) : 
  _viewmodel = viewmodel,
  super(key: key);

  final ClientViewmodel _viewmodel;

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  void initState() {
    super.initState();

    widget._viewmodel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de clientes'),
        actions: [
          IconButton(
            icon: Icon(
              widget._viewmodel.isEncrypt ? Icons.enhanced_encryption : Icons.no_encryption
            ),
            onPressed: () {
              setState(() {
                widget._viewmodel.isEncrypt = !widget._viewmodel.isEncrypt;
                widget._viewmodel.loadData();
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget._viewmodel.createEntity(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<ClientModel>>(
        initialData: const [],
        stream: widget._viewmodel.clientsOut,
        builder: (_, snapshot) => Column(
          children: [
            Expanded(
              child: snapshot.data?.isEmpty ?? true ? const Center(
                child: Text('Não há nenhum cliente'),
              ) : ListTable(
                tableDefinition: ListTableDefinition(
                  endpoint: BackendEndpointsDefinition.clients,
                  items: snapshot.data!.map((e) => e.toMap()).toList(),
                  entityData: snapshot.data!.isNotEmpty ? 
                    snapshot.data![0].toMap() : {},
                  orderData: widget._viewmodel.orderClient,
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
                    Modular.to.navigate(ModulesDefinition.products);
                  }, 
                  child: const Text('Produtos')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/core/widgets/list_table/list_table.dart';
import 'package:flutter_crud/app/models/list_table/list_table_definition.dart';
import 'package:flutter_crud/app/models/user_model.dart';
import 'package:flutter_crud/app/modules/users/users_viewmodel.dart';

class UserPage extends StatefulWidget {
  const UserPage({ 
    Key? key ,
    required UserViewmodel viewmodel,
  }) : 
  _viewmodel = viewmodel,
  super(key: key);

  final UserViewmodel _viewmodel;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();

    widget._viewmodel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de usuários'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget._viewmodel.createEntity(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<UserModel>>(
        initialData: const [],
        stream: widget._viewmodel.usersOut,
        builder: (_, snapshot) => Column(
          children: [
            Expanded(
              child: snapshot.data?.isEmpty ?? true ? const Center(
                child: Text('Não há nenhum usuário'),
              ) : ListTable(
                tableDefinition: ListTableDefinition(
                  endpoint: BackendEndpointsDefinition.users,
                  items: snapshot.data!.map((e) => e.toMap()).toList(),
                  entityData: snapshot.data!.isNotEmpty ? 
                    snapshot.data![0].toMap() : {},
                  orderData: widget._viewmodel.orderUser,
                  deleteEntity: widget._viewmodel.deleteEntity,
                  updateEntity: widget._viewmodel.updateEntity,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {}, 
                  child: const Text('Produtos')
                ),
                ElevatedButton(
                  onPressed: () {}, 
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
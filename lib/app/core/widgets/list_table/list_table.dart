import 'package:flutter/material.dart';
import 'package:flutter_crud/app/models/list_table/list_table_definition.dart';

class ListTable extends StatefulWidget {
  const ListTable({ 
    Key? key,
    required this.tableDefinition,
  }) : super(key: key);

  final ListTableDefinition tableDefinition;

  @override
  State<ListTable> createState() => _ListTableState();
}

class _ListTableState extends State<ListTable> {
  var _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        sortAscending: _isAscending,
        columns: widget.tableDefinition.entityData.keys.map(
          (e) => DataColumn(
            label: Text(e),
            numeric: widget.tableDefinition.entityData[e] is num,
            onSort: (_, isAscending) {
              widget.tableDefinition.orderData(e, _isAscending, widget.tableDefinition.items);
              setState(() {
                _isAscending = !_isAscending;
              });
            },
          )
        ).toList(),
        rows: widget.tableDefinition.items.map(
          (map) => DataRow(
            onLongPress: () => widget.tableDefinition.deleteEntity(map['_id'], context),
            onSelectChanged: (_) {
              widget.tableDefinition.updateEntity(map, context);
            },
            cells: map.keys.map(
              (key) => DataCell(
                Text(map[key]?.toString() ?? ''),
              ),
            ).toList()
          )
        ).toList(),
      ),
    );
  }
}
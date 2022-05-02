import 'package:flutter/widgets.dart';

class ListTableDefinition {
  final Map<String, dynamic> entityData;  
  final List<Map<String, dynamic>> items;
  final void Function(String key, bool isAscending, List<Map<String, dynamic>> data) orderData;
  final Future<void> Function(int id, BuildContext context) deleteEntity;
  final Future<void> Function(Map<String, dynamic> data, BuildContext context) updateEntity;
  final String endpoint;

  ListTableDefinition({
    required this.entityData,
    required this.orderData,
    required this.items,
    required this.endpoint,
    required this.deleteEntity,
    required this.updateEntity,
  });
}

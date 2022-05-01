import 'package:flutter/material.dart';
import 'package:flutter_crud/app/models/create_page/create_page_field_model.dart';

class UpsertPageDetails {
  final List<UpsertPageField> upsertPageField;
  final String titlePage;
  final List<Widget>? children;
  final Future<void> Function(Map<String, dynamic> data) onPressed;
  final String buttonText;
  final bool isLoading;
  
  UpsertPageDetails({
    required this.upsertPageField,
    required this.titlePage,
    required this.onPressed,
    required this.isLoading,
    this.buttonText = 'Fazer Login',
    this.children,
  });
}


import 'package:flutter/widgets.dart';

class UpsertPageField {
  final String key;
  final List<FormFieldValidator>? validators;
  
  UpsertPageField({
    required this.key,
    this.validators,
  });
}

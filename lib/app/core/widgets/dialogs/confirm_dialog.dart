import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({ 
    Key? key,
    this.entity = 'usuário',
    this.contentMessage,
  }) : super(key: key);

  final String? contentMessage;
  final String? entity;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmação'),
      content: Text(contentMessage ?? 'Deseja excluir este $entity ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('CANCELAR')
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true), 
          child: const Text('SIM')
        ),
      ],
    );
  }
}
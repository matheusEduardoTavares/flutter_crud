import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({ 
    Key? key,
    required this.errorContent,
  }) : super(key: key);

  final String errorContent;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erro'),
      content: Text(errorContent),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop, 
          child: const Text('OK')
        )
      ],
    );
  }
}
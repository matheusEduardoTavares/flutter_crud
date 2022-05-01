import 'package:flutter/material.dart';
import 'package:flutter_crud/app/modules/auth/auth_viewmodel.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({ 
    Key? key,
    required AuthViewmodel viewmodel,
  }) : 
  _viewmodel = viewmodel,
  super(key: key);

  // ignore: unused_field
  final AuthViewmodel _viewmodel;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
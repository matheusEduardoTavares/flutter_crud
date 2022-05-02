import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/widgets/upsert_page/upsert_page.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_details_model.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_field_model.dart';
import 'package:flutter_crud/app/modules/login/login_viewmodel.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ 
    Key? key ,
    required LoginViewmodel viewmodel,
  }) : 
  _viewmodel = viewmodel,
  super(key: key);

  final LoginViewmodel _viewmodel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _viewmodel.isLoadingOut,
      builder: (context, snapshot) {
        return UpsertPage(
          upsertPageDetails: UpsertPageDetails(
            isLoading: snapshot.data!,
            titlePage: 'Login',
            onPressed: (data) async {
              _viewmodel.doLogin(
                data: data,
                context: context,
              );
            },
            upsertPageField: [
              UpsertPageField(
                key: 'login',
                validators: [
                  (value) => Validatorless.required('Campo obrigatório')(value),
                  (value) => Validatorless.email('Digite um e-mail')(value),
                ],
              ),
              UpsertPageField(
                key: 'senha',
                validators: [
                  (value) => Validatorless.required('Campo obrigatório')(value),
                  (value) => Validatorless.min(6, 'Digite ao menos 6 palavras')(value),
                ],
              ),
            ],
          )
        );
      }
    );
  }
}
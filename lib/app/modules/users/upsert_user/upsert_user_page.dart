import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/widgets/upsert_page/upsert_page.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_details_model.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_field_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class UpsertUserPage extends StatelessWidget {
  const UpsertUserPage({ 
    Key? key,
    this.title,
    this.userData = const {},
  }) : super(key: key);

  final Map<String, dynamic> userData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return UpsertPage(
      mapData: userData,
      upsertPageDetails: UpsertPageDetails(
        isLoading: false,
        titlePage: '${title ?? 'Atualizar'} usuário',
        buttonText: title ?? 'Atualizar',
        upsertPageField: [
          UpsertPageField(
            key: 'login',
            validators: [Validatorless.required('Campo obrigatório')],
          ),
          UpsertPageField(
            key: 'senha',
            validators: [Validatorless.required('Campo obrigatório')],
          ),
          UpsertPageField(
            key: 'nome',
            validators: [Validatorless.required('Campo obrigatório')],
          ),
        ],
        onPressed: (data) async {
          Modular.to.pop(data);
        },
      ),
    );
  }
}
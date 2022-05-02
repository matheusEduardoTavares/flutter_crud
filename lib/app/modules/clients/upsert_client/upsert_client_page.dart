import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/widgets/upsert_page/upsert_page.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_details_model.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_field_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class UpsertClientPage extends StatelessWidget {
  const UpsertClientPage({ 
    Key? key,
    this.title,
    this.clientData = const {},
  }) : super(key: key);

  final Map<String, dynamic> clientData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return UpsertPage(
      mapData: clientData,
      upsertPageDetails: UpsertPageDetails(
        isLoading: false,
        titlePage: '${title ?? 'Atualizar'} cliente',
        buttonText: title ?? 'Atualizar',
        upsertPageField: [
          UpsertPageField(
            key: 'nome',
            validators: [Validatorless.required('Campo obrigatório')],
          ),
          UpsertPageField(
            key: 'cpf',
            validators: [
              (value) => Validatorless.required('Campo obrigatório')(value),
            ],
          ),
          UpsertPageField(
            key: 'rg',
            validators: [
              (value) => Validatorless.required('Campo obrigatório')(value),
            ],
          ),
        ],
        onPressed: (data) async {
          Modular.to.pop(data);
        },
      ),
    );
  }
}
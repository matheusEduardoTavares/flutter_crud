import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/widgets/upsert_page/upsert_page.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_details_model.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_field_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class UpsertProductPage extends StatelessWidget {
  const UpsertProductPage({ 
    Key? key,
    this.title,
    this.productData = const {},
  }) : super(key: key);

  final Map<String, dynamic> productData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return UpsertPage(
      mapData: productData,
      upsertPageDetails: UpsertPageDetails(
        isLoading: false,
        titlePage: '${title ?? 'Atualizar'} produto',
        buttonText: title ?? 'Atualizar',
        upsertPageField: [
          UpsertPageField(
            key: 'nome',
            validators: [Validatorless.required('Campo obrigatório')],
          ),
          UpsertPageField(
            key: 'estoque',
            validators: [
              (value) => Validatorless.required('Campo obrigatório')(value),
              (value) => Validatorless.number('Digite um número')(value),
            ],
          ),
          UpsertPageField(
            key: 'preco_custo',
            validators: [
              (value) => Validatorless.required('Campo obrigatório')(value),
              (value) => Validatorless.number('Digite um número')(value),
            ],
          ),
          UpsertPageField(
            key: 'preco_venda',
            validators: [
              (value) => Validatorless.required('Campo obrigatório')(value),
              (value) => Validatorless.number('Digite um número')(value),
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
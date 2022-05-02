import 'package:flutter/material.dart';
import 'package:flutter_crud/app/models/upsert_page/upsert_page_details_model.dart';
import 'package:validatorless/validatorless.dart';

class UpsertPage extends StatefulWidget {
  const UpsertPage({ 
    Key? key,
    required this.upsertPageDetails,
    this.mapData,
  }) : 
  super(key: key);

  final UpsertPageDetails upsertPageDetails;
  final Map<String, dynamic>? mapData;

  @override
  State<UpsertPage> createState() => _UpsertPageState();
}

class _UpsertPageState extends State<UpsertPage> {
  late Map<String, dynamic> _mapData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _mapData = {
      ...widget.mapData ?? {},
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.upsertPageDetails.titlePage),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ...(widget.upsertPageDetails.children ?? <Widget>[]),
                ...(widget.upsertPageDetails.upsertPageField.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(e.key)
                      ),
                      onSaved: (value) {
                        _mapData[e.key] = value;
                      },
                      initialValue: _mapData[e.key]?.toString(),
                      validator: e.validators?.isNotEmpty == true ? Validatorless.multiple([
                        ...e.validators!,
                      ]) : null,
                    ),
                  ),
                )),
                widget.upsertPageDetails.isLoading ? const CircularProgressIndicator() : ElevatedButton(
                  child: Text(widget.upsertPageDetails.buttonText),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState!.save();

                      await widget.upsertPageDetails.onPressed(_mapData);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
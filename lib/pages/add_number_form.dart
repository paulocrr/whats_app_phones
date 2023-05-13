import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddNumberForm extends StatefulWidget {
  const AddNumberForm({
    super.key,
  });

  @override
  State<AddNumberForm> createState() => _AddNumberFormState();
}

class _AddNumberFormState extends State<AddNumberForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese numero de telefono'),
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Este valor es requerido'),
                  PatternValidator(
                      r'\(\+51\)\s9((\d{8})|(\d{2}\s\d{3}\s\d{3}))',
                      errorText: 'No es un numero de telefono valido'),
                ],
              ),
              inputFormatters: [
                MaskTextInputFormatter(mask: '(+51) ### ### ###')
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Descripcion'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Formulario valido');
                }
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Agregar WA'),
            )
          ],
        ),
      ),
    );
  }
}

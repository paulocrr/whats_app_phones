import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_app_phones/extensions/whatsapp_contact_extension.dart';
import 'package:whats_app_phones/models/whatsapp_contact.dart';

class AddNumberForm extends StatefulWidget {
  final void Function(WhatsappContact)? onSave;
  const AddNumberForm({
    this.onSave,
    super.key,
  });

  @override
  State<AddNumberForm> createState() => _AddNumberFormState();
}

class _AddNumberFormState extends State<AddNumberForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _descriptionController = TextEditingController();

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
              controller: _phoneNumberController,
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
              controller: _descriptionController,
              maxLength: 20,
              validator:
                  RequiredValidator(errorText: 'Este campo es requerido'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final contact = WhatsappContact(
                    id: const Uuid().v1(),
                    phoneNumber: _phoneNumberController.text,
                    description: _descriptionController.text,
                  );

                  final onSave = widget.onSave;

                  if (onSave != null) {
                    onSave(contact);
                  }

                  _phoneNumberController.clear();
                  _descriptionController.clear();

                  contact.launchWhatAppChat();
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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_app_phones/extensions/whatsapp_contact_extension.dart';
import 'package:whats_app_phones/models/whatsapp_contact.dart';
import 'package:whats_app_phones/pages/add_number_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WhatsappContact> contacts = [];

  @override
  void initState() {
    loadContactList();
    super.initState();
  }

  void loadContactList() async {
    final prefs = await SharedPreferences.getInstance();

    final stringList = prefs.getString('contacts');

    if (stringList != null) {
      setState(() {
        contacts = WhatsappContact.stringToList(stringList);
      });
    }
  }

  void saveCurrentContactList() async {
    final listInString = WhatsappContact.listToString(contacts);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('contacts', listInString);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Numeros de WhatsApp'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Abrir numero en WA'),
                Tab(text: 'Lista de numero'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AddNumberForm(
                onSave: (contact) async {
                  setState(() {
                    contacts.add(contact);
                  });

                  saveCurrentContactList();

                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                children: contacts
                    .map(
                      (contact) => Card(
                        child: ListTile(
                          title: Text(contact.phoneNumber),
                          subtitle: Text(contact.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  contact.launchWhatAppChat();
                                },
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  contact.launchPhoneCall();
                                },
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    contacts.removeWhere(
                                      (element) => element.id == contact.id,
                                    );
                                  });
                                  saveCurrentContactList();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

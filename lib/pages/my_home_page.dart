import 'package:flutter/material.dart';
import 'package:whats_app_phones/pages/add_number_form.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
          body: const TabBarView(
            children: [
              AddNumberForm(),
              Text('Ver numero'),
            ],
          ),
        ),
      ),
    );
  }
}

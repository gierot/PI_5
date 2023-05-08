import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactPage(),
    );
  }
}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> {
  int contador = 0;
  void send_message() {
    contador++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: const Color(0xFF04121F),
      body: Center(
          child: Column(
        children: [
          Image.asset(
            'imagens/21.png',
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical:40),
            child: const Text(
              'Envie uma mensagem para nós',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: const EdgeInsets.symmetric(vertical:40),
            child: TextFormField(
              controller: TextEditingController(),
              scrollPadding: const EdgeInsets.symmetric(vertical: 30),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Mensagem',
                labelStyle: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white, // define a cor do rótulo
                ),
              ),
              textInputAction: TextInputAction.newline, // Permite a quebra de linha ao pressionar Enter
              keyboardType: TextInputType.multiline,
            ),
          ),
          GestureDetector(
            onTap: () => send_message(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child:const Text('Enviar', style: TextStyle(color: Colors.white)),
            )
          )
        ],
      )),
      floatingActionButton: All_buttons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:url_launcher/url_launcher.dart';

Settings settings = Settings();

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

  void redirectToEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    final String webUrl = 'https://mail.google.com/mail/?view=cm&fs=1&to=$email';

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      throw 'Não foi possível abrir o aplicativo de e-mail ou a página web do e-mail.';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: settings.getColor('background'),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'imagens/21.png',
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: const Text(
              'Envie uma mensagem para nós',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(settings.getColor('green_btn')),
              padding: const MaterialStatePropertyAll( EdgeInsets.symmetric(vertical:20, horizontal: 40))
            ),
              onPressed: () => redirectToEmail('contato@vtreffects.com'),
              child: const Text('Enviar', style: TextStyle(color: Colors.white))
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: const Text(
              'Envie uma mensagem para nós sobre, feedbacks, queixas, duvidas...',
              style: TextStyle(color: Colors.white)
            )
          )
          
        ],
      )),
      bottomNavigationBar: BottomAppBar(
          color: settings.getColor('background'),
          height: 40,
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 15.0,
              children: <Widget>[All_buttons()],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

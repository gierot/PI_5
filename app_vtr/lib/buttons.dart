import 'package:flutter/material.dart';
import 'package:app_vtr/perfil/perfil.dart';
import 'package:app_vtr/contact/contact.dart';
import 'package:app_vtr/about/about.dart';

class All_buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Perfil())),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Contact())),
            child: Image.asset(
              'imagens/papel.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Perfil())),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const About())),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Perfil())),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}

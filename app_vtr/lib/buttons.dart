import 'package:flutter/material.dart';
import 'package:app_vtr/perfil/perfil.dart';
import 'package:app_vtr/contact/contact.dart';
import 'package:app_vtr/about/about.dart';
import 'package:app_vtr/forum/forum.dart';
import 'package:app_vtr/home/home.dart';

class All_buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Perfil())
            ),
            child: Image.asset(
              'imagens/10.png',
              height: 40,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Contact())
            ),
            child: Image.asset(
              'imagens/06.png',
              height: 40,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Home())),
            child: Image.asset(
              'imagens/05.png',
              height: 40,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const About())
            ),
            child: Image.asset(
              'imagens/09.png',
              height: 40,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Forum())
            ),
            child: Image.asset(
              'imagens/17.png',
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}

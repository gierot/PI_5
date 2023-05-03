import 'package:flutter/material.dart';
import 'package:app_vtr/perfil/perfil.dart';

class All_buttons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF04121F),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const MyPerfil()
              )
            ),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const MyPerfil()
              )
            ),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const MyPerfil()
              )
            ),
            child: Image.asset(
              'imagens/indefinido.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const MyPerfil()
              )
            ),
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
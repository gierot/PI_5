import 'package:flutter/material.dart';
import 'package:app_vtr/perfil/perfil.dart';
import 'package:app_vtr/main.dart';

class All_buttons extends StatelessWidget {
  

  // void render_forum(){

  // }

  // void render_about(){

  // }

  // void render_products(){

  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => MyApp()
                )
              ),
              child: Image.asset(
                'imagens/pedra.png',
                height: 50,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => MyPerfil()
                )
              ),
              child: Image.asset(
                'imagens/papel.png',
                height: 50,
              ),
            ),
            // GestureDetector(
            //   onTap: () => _iniciaJogada("tesoura"),
            //   // child: Image.asset(
            //   //   'imagens/tesoura.png',
            //   //   height: 90,
            //   // ),
            // ),
          ],
      )
    );
  }
}
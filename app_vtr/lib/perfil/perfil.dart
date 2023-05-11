import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';

Settings settings = Settings();

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyPerfil());
  }
}

class MyPerfil extends StatefulWidget {
  const MyPerfil({super.key});

  @override
  State<MyPerfil> createState() => Perfil_user();
}

class Perfil_user extends State<MyPerfil> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: settings.getColor('background'),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset('imagens/kailane.png', height: 40),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset('imagens/25.png', height: 30,),
                  const Text('testando a aplicação', style: TextStyle(color: Colors.white, fontSize: 18)),
                  Image.asset('imagens/25.png', height: 30,)
                ],
              ) ,
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: GestureDetector(
            //     onTap: () =>,
            //   )
            // ),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: GestureDetector(

            //   ),
            // )
          ],
        ) 
      ),
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

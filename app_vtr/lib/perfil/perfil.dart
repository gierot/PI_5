import 'package:flutter/material.dart';
import 'package:app_vtr/data_user.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/contact/contact.dart';
import 'package:app_vtr/login.dart';

DataUser user_vtr = DataUser();
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
  logout() {
    user_vtr.destroyUser();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
  }

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
                Image.asset(
                  'imagens/25.png',
                  height: 30,
                ),
                const Text('testando a aplicação',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                Image.asset(
                  'imagens/25.png',
                  height: 30,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: settings.getColor('green_btn')),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contact())),
                    child: const Text(
                      'Meus produtos',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: settings.getColor('green_btn')),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contact())),
                    child: const Text(
                      'Editar perfil',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 75),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () => logout(),
                //Navigator.push(context,
                //    MaterialPageRoute(builder: (context) => const Contact())),
                child: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
              )),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: GestureDetector(

          //   ),
          // )
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

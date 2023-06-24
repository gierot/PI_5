import 'package:flutter/material.dart';
import 'package:app_vtr/data_user.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/login.dart';
import 'package:app_vtr/home/home.dart';
import 'package:app_vtr/perfil/edit_perfil.dart';

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
  var name = '';
  var email = '';
  var number = '';

  logout() {
    user_vtr.destroyUser();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  loadingValuesUser() async {
    var getname = await user_vtr.getToken('name');
    var getemail = await user_vtr.getToken('email');
    var getnumber = await user_vtr.getToken('telefone');
    setState(() {
      name = getname;
      email = getemail;
      number = getnumber;
    });
  }

  @override
  void initState() {
    super.initState();
    loadingValuesUser();
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
            child: Image.asset('imagens/kailane.png', height: 60),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Image.asset('imagens/25.png', height: 30),
                Text(name,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 15),
                Text(email,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 15),
                Text(number,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                Image.asset(
                  'imagens/25.png',
                  height: 30,
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Home(1))),
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 25, horizontal: 60)),
              backgroundColor:
                  MaterialStatePropertyAll(Color(0xFF1E0B8E)),
            ),
            child: const Text(
              'Meus produtos',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPerfil(name, number, email))),
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 25, horizontal: 72)),
              backgroundColor:
                  MaterialStatePropertyAll(settings.getColor('color_font')),
            ),
            child: const Text(
              'Editar perfil',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => logout(),
            style: const ButtonStyle(
              padding:  MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 25, horizontal: 100)),
              backgroundColor:
                  MaterialStatePropertyAll(Colors.red),
            ),
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
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

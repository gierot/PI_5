import 'package:app_vtr/login.dart';
import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/setting.dart';

Settings settings = Settings();

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  Color border_color = Colors.white;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController id_people = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  void registerUser() async {
    Map<String, String> body = {
      'email': email.text,
      'name': name.text,
      'password': password.text,
      'telefone': number.text,
      'cpfcnpj': id_people.text,
    };

    var response = await settings.registerUser(body);
    if(!response){
      Navigator.push(context,MaterialPageRoute(builder: (context) => const Login()));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ocorreu um erro. Por favor, tente novamente.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: const Color(0xFF04121F),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nome',
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white, // define a cor do rótulo
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white, // define a cor do rótulo
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: id_people,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'CPF / CNPJ',
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white, // define a cor do rótulo
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Numero / Telefone',
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white, // define a cor do rótulo
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: password,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Senha',
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white, // define a cor do rótulo
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GestureDetector(
                  onTap: () => registerUser(),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ])),
    );
  }
}

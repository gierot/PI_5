import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  int _counter = 0;
  Color border_color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: const Color(0xFF04121F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Image.asset(
                'imagens/user.png',
                height: 24,
              ), 
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: const Text('Acessar sua conta', style: TextStyle(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Email',
                  labelStyle:const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white, // define a cor do rótulo
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
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
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFbdb133),
              ),
              child:const Text('Entrar', style: TextStyle(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      text: const TextSpan(
                        text: 'OU',
                      ),
                    )
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('imagens/google.png', height: 20, width: 20,),
                  const Text('Login com Google', style:TextStyle(fontSize: 14))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('imagens/outlook.png', height: 20, width: 20,),
                  const Text('Login com Outlook', style: TextStyle(fontSize: 14),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
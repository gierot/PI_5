import 'package:app_vtr/about/about.dart';
import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/register.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/data_user.dart';
import 'package:app_vtr/message.dart';

DataUser data = DataUser();
Settings settings = Settings();

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
  Color border_color = Colors.white;

  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();

  void verifyAccount() async {
    Map<String, String> body = {'email': login.text, 'password': password.text};
    await data.setUnityToken(password.text, 'password');

    var response = await settings.getAccountData(body);
    if (!response) {
      MessageSnackBar(
        'Login/Senha incorretos.\nPor favor, tente novamente.', 1
      ).show(context);
      return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const About()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: const Color(0xFF04121F),
      body:SingleChildScrollView(
        child: Center(
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
                child: const Text(
                  'Acessar sua conta',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: TextFormField(
                    controller: login,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "email",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: const Color(0xFFbdb133),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFbdb133),
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: TextFormField(
                    controller: password,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: const Color(0xFFbdb133),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFbdb133),
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () => verifyAccount(),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
                    backgroundColor: MaterialStateProperty.all(settings.getColor('color_font')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Defina o raio desejado aqui
                      ),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Register())),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                    backgroundColor: MaterialStateProperty.all(settings.getColor('green_btn')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Defina o raio desejado aqui
                      ),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              text: 'OU', style: TextStyle(color: Colors.white)),
                        )),
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                        height: 10,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => '',
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF1E0B8E)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Defina o raio desejado aqui
                    ),
                  ),
                ),
                child: const Text(
                  'Entrar como convidado',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

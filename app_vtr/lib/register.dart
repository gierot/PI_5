import 'package:app_vtr/login.dart';
import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/setting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_vtr/message.dart';
import 'dart:convert';
import 'dart:io';


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
  final picker = ImagePicker();
  Color border_color = Colors.white;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController id_people = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  String base64Image = '';

  uploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File _img = File(image.path);
      // print(Text(_img.path));
      settings.postImage(_img.path);
      // final imageBytes = await image.readAsBytes();
      // setState(() {
      //   base64Image = base64Encode(imageBytes);
      // });
      // print(base64Image);
    }
  }

  void registerUser() async {
    if (email.text.isEmpty ||
        name.text.isEmpty ||
        password.text.isEmpty ||
        number.text.isEmpty ||
        id_people.text.isEmpty) {
      MessageSnackBar('Um dos campos não foi definido!', 1).show(context);
      return;
    }
    Map<String, String> body = {
      'email': email.text,
      'name': name.text,
      'password': password.text,
      'telefone': number.text,
      'cpfcnpj': id_people.text,
    };

    var response = await settings.registerUser(body);
    if (!response) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    MessageSnackBar('Ocorreu um erro. Por favor, tente novamente.', 1)
        .show(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => uploadImage(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 27, horizontal: 20),
                    backgroundColor: Colors.white,
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => registerUser(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    backgroundColor: settings.getColor('green_btn'),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: TextFormField(
                  controller: name,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.white,
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
                    fillColor: Colors.white,
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
                  controller: email,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "email",
                    labelStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.white,
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
                  controller: id_people,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "CPF | CNPJ",
                    labelStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.white,
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
                  controller: number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Numero | Telefone',
                    labelStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.white,
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
          ])),
    );
  }
}

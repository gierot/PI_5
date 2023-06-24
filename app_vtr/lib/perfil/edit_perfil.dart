import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_vtr/data_user.dart';
import 'package:app_vtr/message.dart';
import 'dart:async';
import 'dart:io';

DataUser data = DataUser();
Settings settings = Settings();

class EditPerfil extends StatelessWidget {
  final String name;
  final String number;
  final dynamic email;
  EditPerfil(this.name, this.number, this.email);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditPerfilPage(name, number, email),
    );
  }
}

class EditPerfilPage extends StatefulWidget {
  final String name;
  final String number;
  final dynamic email;
  EditPerfilPage(this.name, this.number, this.email);

  @override
  State<EditPerfilPage> createState() => _EditPerfilPage();
}

class _EditPerfilPage extends State<EditPerfilPage> {
  final picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpf = TextEditingController();
  String base64Image = '';
  String _img = '';

  uploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File _attimg = File(image.path);
      settings.postImageAuth(_attimg.path);
      // _img = _attimg.path;
    }
  }

  void defaultValues() async {
    var id_cpf = await data.getToken('cpf');
    var pass = await data.getToken('password');
    _img = await data.getToken('foto');
    setState(() {
      name.text = widget.name;
      number.text = widget.number;
      email.text = widget.email;
      password.text = pass;
      cpf.text = id_cpf;
    });
  }

  void savePerfil() async {
    if (name.text.isEmpty ||
        number.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        cpf.text.isEmpty) {
      MessageSnackBar('Um dos campos não foi definido!', 1).show(context);
      return;
    }

    Map<String, dynamic> data = {
      'nome': name.text,
      'email': email.text,
      'cpfcnpj': cpf.text,
      'telefone': number.text
    };

    var response = settings.updatePerfil(data);
    
    if(response == true){
      Timer(const Duration(seconds: 5), () {
        MessageSnackBar('Perfil atualizado com sucesso!', 2).show(context);
      });
    }
    MessageSnackBar('Perfil atualizado com sucesso!', 2).show(context);
  }

  void initState() {
    super.initState();
    defaultValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: settings.getColor('background'),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  child: Image.network(
                    _img,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => savePerfil(),
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
                  controller: number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Numero",
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
                  controller: cpf,
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
          ],
        )),
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

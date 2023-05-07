import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';

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
      backgroundColor: const Color(0xFF04121F),
      //body: ,
      floatingActionButton: All_buttons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

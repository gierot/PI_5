import 'package:flutter/material.dart';

class MyPerfil extends StatefulWidget {
  const MyPerfil({super.key});

  @override
  State<MyPerfil> createState() => Perfil_user();
}

class Perfil_user extends State<MyPerfil> {
  int _counter = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    ));
  }
}

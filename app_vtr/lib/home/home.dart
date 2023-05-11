import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';

Settings settings = Settings();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<String> nomes = ['João', 'Maria', 'Pedro', 'Gustavo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.getColor('background'),
      appBar: Top(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: 
            nomes.map((nome) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal:40, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical:25, horizontal:40),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('imagens/09.png', height: 50,),
                    Text(nome, style: const TextStyle(color: Colors.black),)
                  ]
                ),
              );
            }).toList()
          ),
        ),
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

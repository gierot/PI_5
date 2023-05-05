import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/render_video.dart';

Future<String> textInFile() async {
  String text = '';
  try {
    text = await File('assets/text.txt').readAsString();
  } catch (e) {
    //
  }
  return text;
}
class About extends StatelessWidget {
  const About({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {

String _fileContent = '';

  @override
  void initState() {
    super.initState();
    _loadFileContent();
  }

  Future<void> _loadFileContent() async {
    String content = await textInFile();
    setState(() {
      _fileContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(),
      backgroundColor: const Color(0xFF04121F),
      body: SingleChildScrollView(
          child:Center(
            child: Column(
              children:  [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical:10),
                  child: Text('Vtr Efects', style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(_fileContent, style: const TextStyle(color: Colors.white, fontSize: 10),),
                ),
                const YoutubePlayerScreen(linkvideo: 'https://youtu.be/shH6FgfZQUM'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Em 2020, a VTR Effects entrou para o portfolio de projetos investidos pelo Polo Zaia. Assim se instalando dentro da Planer InovaCenter (Serra-ES), um hub de inovações criado pela faculdade UCL para ajudar no desenvolvimento de projetos inovadores e tecnologicos.', 
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(width:8),
                      Image.asset('imagens/indefinido.png', height: 80, width: 80,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Column( children:[
                      Image.asset('imagens/logo.png', height: 50),
                      const SizedBox(height:8),
                      const Text('Visão', style: TextStyle(color: Colors.white, fontSize: 18),),
                      const SizedBox(height:8),
                      const Text(
                        '“Superar as expectativas do mercado com nossos produtos, inspirando músicos onde quer que estejam.”',
                        style: TextStyle(color: Colors.white, fontSize: 10,),
                        textAlign: TextAlign.center,
                      )
                    ])
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 30 )),
              ],
            ),
          )
        ),
      floatingActionButton: All_buttons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

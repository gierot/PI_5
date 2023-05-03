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
                const Padding(padding: EdgeInsets.symmetric(vertical: 30 )),
              ],
            ),
          )
        ),
      floatingActionButton: All_buttons(),
    );
  }
}

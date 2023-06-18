import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'dart:convert';

Settings settings = Settings();

class OpenForum extends StatelessWidget {
  final int id;
  final String titulo;
  final String descricao;
  const OpenForum(this.id, this.titulo, this.descricao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OpenForumPage(id, titulo, descricao),
    );
  }
}

class OpenForumPage extends StatefulWidget {
  final int id;
  final String titulo;
  final String descricao;

  const OpenForumPage(this.id, this.titulo, this.descricao);
  @override
  State<OpenForumPage> createState() => _OpenForumPage();
}

class _OpenForumPage extends State<OpenForumPage> {
  Map<String, dynamic> coments = {};

  void getForums() async {
    Map<String, dynamic> values = await settings.getComents(widget.id);
    setState(() {
      coments = values;
    });
  }

  @override
  void initState() {
    super.initState();
    getForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.getColor('background'),
      appBar: Top(),
      body: ListView.builder(
        itemCount: coments['comentarios'].length,
        itemBuilder: (context, index) {
          dynamic item = coments['comentarios'][index];
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['comentario'].toString(),
                      style: const TextStyle(color: Colors.white)),
                  // if (jsonDecode(item['respostas']).length > 0)
                  //   ListView.builder(
                  //     itemCount: jsonDecode(item['respostas']).length,
                  //     itemBuilder: (context, index) {
                  //       dynamic data = item['respostas'][index];
                  //       return Container(
                  //           margin: const EdgeInsets.symmetric(vertical: 30),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(data['comentario'].toString(),
                  //                   style: const TextStyle(color: Colors.white))
                  //             ],
                  //           ));
                  //     },
                  //   ),
                ],
              ));
        },
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

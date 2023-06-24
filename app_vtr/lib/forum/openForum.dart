import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/forum/openForum.dart';
import 'package:app_vtr/data_user.dart';
import 'package:app_vtr/message.dart';
import 'dart:async';

DataUser data = DataUser();
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
  TextEditingController coment = TextEditingController();
  TextEditingController edit = TextEditingController();

  Map<String, dynamic> coments = {};
  var user_id;

  void getForums() async {
    Map<String, dynamic> values = await settings.getComents(widget.id);
    setState(() {
      coments = values;
    });
  }

  void sendComent() async {
    Navigator.pop(context);
    if(coment.text.isEmpty){
      MessageSnackBar('Não foi possivel salvar o comentario, pois, não há conteudo!', 1)
          .show(context);
      return;
    }
    Map<String, dynamic> data = {
      'forum_id': widget.id.toInt(),
      'comentario': coment.text,
      //... (1 > 3 ? {'comentario': 1} : {})
    };

    var send_coment = await settings.sendComent(data);

    if (!send_coment) {
      MessageSnackBar('Não foi possivel salvar o comentario!', 1)
          .show(context);
      return;
    }
    MessageSnackBar('Comentario salvo com sucesso!', 2)
          .show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OpenForum(widget.id, widget.titulo, widget.descricao),
        ),
      );
    });
  }

  void likeComent(int id) async {
    Map<String, dynamic> data = {'comentario_id': id};
    var is_liked = await settings.likeComent(data);

    if (is_liked) {}
  }

  void unlikeComent(int id) async {
    Map<String, dynamic> data = {'comentario_id': id};

    var is_unlike = await settings.unlikeComent(data);

    if (is_unlike) {}
  }

  void deleteComent(int id) async {
    var delete_coment = await settings.deleteComent(id);

    if (!delete_coment) {
      MessageSnackBar('Não foi possivel excluir o comentario.', 1)
          .show(context);
      return;
    }
    MessageSnackBar('Comentario excluido com sucesso!', 2).show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OpenForum(widget.id, widget.titulo, widget.descricao),
        ),
      );
    });
  }

  void editComent(int id) async {
    Navigator.pop(context);
    if (edit.text.isEmpty) {
      MessageSnackBar(
              'Não foi possivel atualizar o comentario, pois, não há conteudo!',
              1)
          .show(context);
      return;
    }

    Map<String, dynamic> data = {'comentario': edit.text};

    var edit_coment = await settings.updateComent(id, data);

    if(!edit_coment){
      MessageSnackBar('Não foi possivel editar o comentario.', 1)
          .show(context);
      return;
    }
    MessageSnackBar('Comentario editado com sucesso!', 2).show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OpenForum(widget.id, widget.titulo, widget.descricao),
        ),
      );
    });
  }

  void getIdUser() async {
    var id = await data.getToken('id');
    setState(() {
      user_id = id;
    });
  }

  @override
  void initState() {
    super.initState();
    getIdUser();
    getForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.getColor('background'),
      appBar: Top(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(coments['titulo'],
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(height: 20),
              Text(coments['descricao'],
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
            ]),
          ),
          const SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: TextFormField(
                                  controller: coment,
                                  scrollPadding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Comentario',
                                    labelStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                )),
                            ElevatedButton(
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Enviar'), Icon(Icons.send)]),
                              onPressed: () => sendComent(),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
                                backgroundColor:
                                    MaterialStateProperty.all(settings.getColor('green_btn')),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // Defina o raio desejado aqui
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                  backgroundColor:
                      MaterialStateProperty.all(settings.getColor('green_btn')),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Defina o raio desejado aqui
                    ),
                  ),
                ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Enviar um comentario'), Icon(Icons.send)]),
              )),
          const SizedBox(height: 20),
          Expanded(
              child: ListView.builder(
            itemCount: coments['comentarios'] != null
                ? coments['comentarios'].length
                : 0,
            itemBuilder: (context, index) {
              dynamic item = coments['comentarios'] != null ? coments['comentarios'][index] : null;
              if (item != null) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            color: settings.getColor('color_font'),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: Text(
                            item['comentario'].toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => likeComent(item['id'].toInt()),
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 16,
                                  child: Icon(
                                    Icons.favorite,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (item['usuario_id'].toString() == user_id)
                                IconButton(
                                  onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets
                                                        .symmetric(
                                                    vertical: 10,
                                                    horizontal: 40),
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: 10,
                                                    horizontal: 40),
                                                child: TextFormField(
                                                  controller: coment,
                                                  scrollPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 30),
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.black),
                                                  decoration:
                                                      InputDecoration(
                                                    border:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .black),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  10),
                                                    ),
                                                    labelText:
                                                        'Comentario',
                                                    labelStyle:
                                                        const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  textInputAction:
                                                      TextInputAction
                                                          .newline,
                                                  keyboardType:
                                                      TextInputType
                                                          .multiline,
                                                )),
                                            ElevatedButton(
                                              child: const Text('Salvar'),
                                              onPressed: () =>
                                                  editComent(item['id'].toInt()),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 16,
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              if (item['usuario_id'].toString() == user_id)
                                IconButton(
                                  onPressed: () => deleteComent(item['id'].toInt()),
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 16,
                                    child: Icon(
                                      Icons.delete,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ])
                      ])),
                  ],
                );
              } else {
                return Container(); // Ou qualquer outro widget vazio que você preferir
              }
            },
          )),
        ],
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

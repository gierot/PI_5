import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/forum/openForum.dart';
import 'package:app_vtr/forum/forum.dart';
import 'package:app_vtr/message.dart';
import 'dart:async';

Settings settings = Settings();

class Forum extends StatelessWidget {
  const Forum({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  TextEditingController title = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController content = TextEditingController();
  List<dynamic> forums = [];

  void getForums() async {
    List<dynamic> values = await settings.getForums();
    setState(() {
      forums = values;
    });
  }

  void sendQuestion() async {
    Navigator.pop(context);
    if (title.text.isEmpty || question.text.isEmpty || content.text.isEmpty) {
      MessageSnackBar(
              'Não foi possivel salvar o forum, pois, não há conteudo!', 1)
          .show(context);
      return;
    }
    Map<String, String> data = {
      'titulo': title.text,
      'descricao': question.text,
      'comentario': content.text
    };

    var is_valid = await settings.sendForum(data);

    if (!is_valid) {
      MessageSnackBar('Não foi possivel salvar o forum!', 1).show(context);
      return;
    }
    MessageSnackBar('Forum salvo com sucesso!', 2).show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Forum(),
        ),
      );
    });
  }

  void updateforum(int id) async {
    Navigator.pop(context);
    if (title.text.isEmpty || question.text.isEmpty || content.text.isEmpty) {
      MessageSnackBar(
              'Não foi possivel atualizar o forum, pois, não há conteudo!', 1)
          .show(context);
      return;
    }

    Map<String, String> data = {
      'titulo': title.text,
      'descricao': question.text,
      'comentario': content.text
    };

    var update_forum = await settings.updateForum(id, data);

    if (!update_forum) {
      MessageSnackBar('Não foi possivel atualizar o forum!', 1).show(context);
      return;
    }
    MessageSnackBar('Forum atualizado com sucesso!', 2).show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Forum(),
        ),
      );
    });
  }

  void deleteForum(int id) async {
    var delete_forum = await settings.deleteForum(id);

    if (!delete_forum) {
      MessageSnackBar('Não foi possivel deletar o forum!', 1).show(context);
      return;
    }
    MessageSnackBar('Forum deletado com sucesso!', 2).show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Forum(),
        ),
      );
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
      body: Column(
        children: [
          const Text('Forum',
              style: TextStyle(color: Colors.white, fontSize: 24)),
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
                                  controller: title,
                                  scrollPadding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Titulo',
                                    labelStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: TextFormField(
                                  controller: question,
                                  scrollPadding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Questão',
                                    labelStyle: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: TextFormField(
                                  controller: content,
                                  scrollPadding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Conteudo',
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
                              onPressed: () => sendQuestion(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25)),
                  backgroundColor: MaterialStateProperty.all(
                      settings.getColor('color_font')),
                ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Enviar uma pergunta'), Icon(Icons.send)]),
              )),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: forums != null ? forums.length : 0,
              itemBuilder: (context, index) {
                dynamic item = forums[index];
                if (item != null) {
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 50),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OpenForum(
                                    item['id'],
                                    item['titulo'].toString(),
                                    item['descricao'].toString(),
                                  ),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 25)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(item['titulo'].toString(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      deleteForum(item['id'].toInt()),
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
                                IconButton(
                                  onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                child: TextFormField(
                                                  controller: title,
                                                  scrollPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 30),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    labelText: 'Titulo',
                                                    labelStyle: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  textInputAction:
                                                      TextInputAction.newline,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                )),
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                child: TextFormField(
                                                  controller: question,
                                                  scrollPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 30),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    labelText: 'Questão',
                                                    labelStyle: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  textInputAction:
                                                      TextInputAction.newline,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                )),
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                child: TextFormField(
                                                  controller: content,
                                                  scrollPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 30),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    labelText: 'Conteudo',
                                                    labelStyle: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  textInputAction:
                                                      TextInputAction.newline,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                )),
                                            ElevatedButton(
                                              child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('Enviar'),
                                                    Icon(Icons.send)
                                                  ]),
                                              onPressed: () => updateforum(
                                                  item['id'].toInt()),
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
                              ]),
                          const SizedBox(height: 30),
                        ],
                      ));
                } else {
                  return Container();
                }
              },
            ),
          ),
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

import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/forum/openForum.dart';
import 'package:app_vtr/data_user.dart';

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
  Map<String, dynamic> coments = {};
  var user_id;

  void getForums() async {
    Map<String, dynamic> values = await settings.getComents(widget.id);
    setState(() {
      coments = values;
    });
  }

  void sendComent() async {
    Map<String, dynamic> data = {
      'forum_id': widget.id.toInt(),
      'comentario': coment.text,
      //... (1 > 3 ? {'comentario': 1} : {})
    };

    var send_coment = await settings.sendComent(data);

    if (send_coment) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OpenForum(widget.id, widget.titulo, widget.descricao),
        ),
      );
    }
  }

  void like() {}

  void editComent() async {}

  void getIdUser() async {
    var id = await data.getToken('id');
    setState(() {
      user_id = id;
    });
  }

  void likeComent(coment_id) async {
    Map<String, dynamic> body = {'comentario_id': coment_id};
    settings.likeComent(body);
  }

  void removeLike() {}

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
        children: [
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
                                      fontSize: 12.0,
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
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Enviar um comentario'), Icon(Icons.send)]),
              )),
          Expanded(
              child: ListView.builder(
            itemCount: coments['comentarios'] != null
                ? coments['comentarios'].length
                : 0,
            itemBuilder: (context, index) {
              dynamic item = coments['comentarios'] != null
                  ? coments['comentarios'][index]
                  : null;
              if (item != null) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            item['comentario'].toString(),
                            style:
                                const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4)),
                                ),
                                child: const Icon(
                                  Icons.favorite,
                                  size: 20,
                                ),
                                onPressed: () =>
                                    likeComent(item['comentario_id']),
                              ),
                              if (item['usuario_id'].toString() == user_id)
                                ElevatedButton(
                                    child: const Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5),
                                            child: Column(
                                              mainAxisSize:
                                                  MainAxisSize.min,
                                              children: [
                                                Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                    padding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 10,
                                                            horizontal: 40),
                                                    child: TextFormField(
                                                      controller: coment,
                                                      scrollPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 30),
                                                      style:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .black),
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
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.black,
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
                                                  child:
                                                      const Text('Salvar'),
                                                  onPressed: () =>
                                                      sendComent(),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              if (item['usuario_id'].toString() == user_id)
                                ElevatedButton(
                                  onPressed: () => removeLike(),
                                  child: const Icon(Icons.delete),
                                )
                            ])
                        ]
                      )
                    ),
                    Column(
                      children: item['respostas'].map<Widget>((coment) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: Column(children: [
                            Text(coment['comentario'].toString(),
                                style: const TextStyle(color: Colors.white)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 4)),
                                    ),
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        likeComent(coment['comentario_id']),
                                  ),
                                  if (coment['usuario_id'].toString() == user_id)
                                    ElevatedButton(
                                        child: const Icon(Icons.edit),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 10,
                                                            horizontal: 40),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 40),
                                                        child: TextFormField(
                                                          controller: coment,
                                                          scrollPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 30),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
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
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
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
                                                      child:
                                                          const Text('Salvar'),
                                                      onPressed: () =>
                                                          sendComent(),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  if (coment['usuario_id'].toString() == user_id)  
                                    ElevatedButton(
                                      onPressed: () => removeLike(),
                                      child: const Icon(Icons.delete),
                                    )
                                  
                                ])
                          ]),
                        );
                      }).toList(),
                    ),
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

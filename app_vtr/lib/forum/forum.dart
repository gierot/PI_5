import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/forum/openForum.dart';
import 'package:app_vtr/forum/forum.dart';

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
    Map<String, String> data = {
      'titulo': title.text,
      'descricao': question.text,
      'comentario': content.text
    };

    var is_valid = await settings.sendForum(data);

    if (is_valid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Forum(),
        ),
      );
    }
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
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            child: TextFormField(
                              controller: title,
                              scrollPadding:const EdgeInsets.symmetric(vertical: 30),
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
                            )
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            child: TextFormField(
                              controller: question,
                              scrollPadding:const EdgeInsets.symmetric(vertical: 30),
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
                            )
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            child: TextFormField(
                              controller: content,
                              scrollPadding:const EdgeInsets.symmetric(vertical: 30),
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
                            )
                          ),
                          ElevatedButton(
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Enviar'), Icon(Icons.send)]),
                            onPressed: () => sendQuestion() ,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Enviar uma pergunta'), Icon(Icons.send)]),
            )
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: forums.length,
              itemBuilder: (context, index) {
                dynamic item = forums[index];
                return Column(
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
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 25)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        item['titulo'].toString(),
                        style: const TextStyle(color: Colors.white)
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
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

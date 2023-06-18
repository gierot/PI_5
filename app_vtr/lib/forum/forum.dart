import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/forum/openForum.dart';

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
  List<dynamic> forums = [];

  void getForums() async {
    List<dynamic> values = await settings.getForums();
    setState(() {
      forums = values;
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
        itemCount: forums.length,
        itemBuilder: (context, index) {
          dynamic item = forums[index];
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => OpenForum(item['id'], item['titulo'].toString(), item['descricao'].toString()))
                    ),
                    child: Text(item['titulo'].toString(),
                      style: const TextStyle(color: Colors.white)),
                  )
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

import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/home/product.dart';

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
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    List<dynamic> values = await settings.getProducts();
    setState(() {
      products = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.getColor('background'),
      appBar: Top(),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          dynamic item = products[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item['nome'].toString(), style: const TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () => 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                      Product(
                        item['nome'].toString(),
                        item['descricao'].toString(),
                        item['caminho'].toString(),
                        item['link_video'].toString(),
                        item['link'].toString()
                      )
                    )
                  ),
                  child: Image.network(item['caminho'], height: 150,),
                )
              ],
            )
          );
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

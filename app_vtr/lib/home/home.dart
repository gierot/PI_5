import 'package:flutter/material.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/home/product.dart';

Settings settings = Settings();

class Home extends StatelessWidget {
  final int is_user;

  const Home(this.is_user);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(is_user),
    );
  }
}

class HomePage extends StatefulWidget {
  final int is_user;
  const HomePage(this.is_user);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    widget.is_user == 0 ? loadProducts() : loadProductsUser();
  }

  void loadProducts() async {
    List<dynamic> values = await settings.getProducts();
    setState(() {
      products = values;
    });
  }

  void loadProductsUser() async {
    List<dynamic> values = await settings.getProductsUser();
    setState(() {
      products = values;
    });
    print(products);
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
                  Text(item['nome'].toString(),
                      style: const TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Product(
                                item['id'],
                                item['nome'].toString(),
                                item['descricao'].toString(),
                                item['caminho'].toString(),
                                item['link_video'].toString(),
                                item['link'].toString(),
                                widget.is_user))),
                    child: Image.network(
                      item['caminho'],
                      height: 150,
                    ),
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

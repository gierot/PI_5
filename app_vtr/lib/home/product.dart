import 'package:flutter/material.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/render_video.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_vtr/home/home.dart';

Settings settings = Settings();

class Product extends StatelessWidget {
  final int id;
  final String name;
  final String info_text;
  final String link_video;
  final String image;
  final String redirect_product;
  final int is_user;

  const Product(this.id, this.name, this.info_text, this.image, this.link_video,
      this.redirect_product, this.is_user);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(
          id, name, info_text, image, link_video, redirect_product, is_user),
    );
  }
}

class ProductPage extends StatefulWidget {
  final int id;
  final String name;
  final String info_text;
  final String link_video;
  final String image;
  final String redirect_product;
  final int is_user;

  const ProductPage(this.id, this.name, this.info_text, this.image,
      this.link_video, this.redirect_product, this.is_user);

  @override
  State<ProductPage> createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  TextEditingController email_user = TextEditingController();
  var manual = '';
  var garantia;
  var error = false;

  void _launchURL() async {
    var url = widget.redirect_product;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }

  sendProduct() async {
    Map<String, String> body = {
      'new_user_email': email_user.text,
      'usuario_produto_id': widget.id.toString()
    };

    var response = await settings.sendProduct(body);

    if (response == true) {
      setState(() { error = false; });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home(1)));
    } else {
      setState(() {
        error = true;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.red,
      //     elevation: 10000,
      //     content: Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 0),
      //       width: 600, // Define um tamanho fixo para o SnackBar
      //       child: const Text(
      //         'Não foi possivel enviar o produto! Por favor verifique o email do destinatario.',
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.white, fontSize: 16),
      //       ),
      //     ),
      //   ),
      // );
    }
  }

  void getManual() async {
    manual = await settings.getManual(1);
  }

  void getGarantias() async {
    garantia = await settings.getGarantia();
  }

  @override
  void initState() {
    super.initState();
    setState(() { error = false; });
    getManual();
    getGarantias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.getColor('background'),
      appBar: Top(),
      body: SingleChildScrollView(
          child: Center(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
              ElevatedButton(
                  child: const Text(
                    'Manual',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                manual,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                child: const Text('Fechar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  })
            ],
          ),
          Image.network(widget.image, height: 100),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(widget.info_text,
                  style: const TextStyle(color: Colors.white))),
          YoutubePlayerScreen(linkvideo: widget.link_video),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.is_user == 0)
                ElevatedButton(
                  onPressed: _launchURL,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF31B425)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25))),
                  child: const Text('Comprar no site',
                      style: TextStyle(color: Colors.white)),
                ),
              if (widget.is_user == 1)
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF31B425)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25))),
                  child: const Text('Tranferir',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Container(
                              // Conteúdo do ModalBottomSheet
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: const Text(
                                        'Digite o email do destinatário do produto!'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: TextFormField(
                                      controller: email_user,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: 'Email',
                                        labelStyle: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: sendProduct,
                                    child: const Text('Transferir'),
                                  ),
                                ],
                              ),
                            ),
                            if (error == true)
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  // Seu componente de mensagem de alerta
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(16),
                                  child: const Text(
                                    'Por favor verifique o email do destinatario.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF31B425)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25))),
                child: const Text('garantia',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16.0),
                            Text(
                              garantia[widget.id - 1]['nome'].toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              garantia[widget.id - 1]['hash'].toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              child: const Text('Fechar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          )
        ]),
      )),
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

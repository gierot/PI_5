import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/render_video.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_vtr/home/home.dart';
import 'package:app_vtr/message.dart';
import 'dart:async';

Settings settings = Settings();

class Product extends StatelessWidget {
  final int id;
  final String name;
  final String info_text;
  final String link_video;
  final String image;
  final String redirect_product;
  final int is_user;
  final int id_user;

  const Product(this.id, this.name, this.info_text, this.image, this.link_video,
      this.redirect_product, this.is_user, this.id_user);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(id, name, info_text, image, link_video,
          redirect_product, is_user, id_user),
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
  final id_user;

  const ProductPage(this.id, this.name, this.info_text, this.image,
      this.link_video, this.redirect_product, this.is_user, this.id_user);

  @override
  State<ProductPage> createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  TextEditingController email_user = TextEditingController();
  var manual = '';
  var garantia;

  void _launchURL() async {
    var url = widget.redirect_product;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }

  sendProduct() async {
    Navigator.pop(context);
    if (email_user.text.isEmpty) {
      MessageSnackBar(
          'Não foi possivel transferir o produto, pois, não há email para o envio!',
          1);
      return;
    }
    Map<String, String> body = {
      'new_user_email': email_user.text,
      'usuario_produto_id': widget.id_user.toString()
    };

    var response = await settings.sendProduct(body);

    if (!response) {
      MessageSnackBar(
          'Não foi possivel transferir o produto, pois, não há email para o envio!',
          1);
      return;
    }
    MessageSnackBar('Produto enviado com sucesso!', 2).show(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(1),
        ),
      );
    });
  }

  void getManual() async {
    var values = await settings.getManual(1);
    setState(() {
      manual = values;
    });
  }

  void getGarantias() async {
    var values = await settings.getGarantia();
    setState(() {
      garantia = values.firstWhere((item) => item['id'] == widget.id,
          orElse: () => null);
    });
  }

  @override
  void initState() {
    super.initState();
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                manual,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
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
                          (states) => const Color(0xFF1E0B8E)),
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
                          (states) => settings.getColor('color_font')),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25))),
                  child: const Text('Tranferir',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
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
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirmação'),
                                            content: const Text(
                                                'Deseja confirmar esta ação?'),
                                            actions: [
                                              TextButton(
                                                child: Text('Cancelar'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Confirmar'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  sendProduct();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Transferir'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              if (widget.is_user == 1)
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF1E0B8E)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25))),
                  child: const Text('Garantia',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: 16.0),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  garantia['nome'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  garantia['hash'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Validade até: ' +
                                      garantia['validade'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Data de compra: ' +
                                      garantia['data_compra'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                garantia[widget.id - 1]['validade'].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
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

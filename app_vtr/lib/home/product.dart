import 'package:flutter/material.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/render_video.dart';
import 'package:url_launcher/url_launcher.dart';

Settings settings = Settings();

class Product extends StatelessWidget {
  final String name;
  final String info_text;
  final String link_video;
  final String image;
  final String redirect_product;

  const Product(this.name, this.info_text, this.image, this.link_video,
      this.redirect_product);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(
        name,
        info_text,
        image,
        link_video,
        redirect_product,
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  final String name;
  final String info_text;
  final String link_video;
  final String image;
  final String redirect_product;

  const ProductPage(this.name, this.info_text, this.image, this.link_video,
      this.redirect_product);

  @override
  State<ProductPage> createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  var manual = '';
  var garantia = '';
  void _launchURL() async {
    var url = widget.redirect_product;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }

  void getManual() async {
    manual = await settings.getManual(1);
    //garantia = await settings.getGarantia();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getManual();
    });
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
                  child: const Text('Manual', style: TextStyle(color: Colors.white),),
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
              ElevatedButton(
                child: const Text('garantia',
                    style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF31B425)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25))),
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

import 'package:flutter/material.dart';
import 'package:app_vtr/setting.dart';
import 'package:app_vtr/top.dart';
import 'package:app_vtr/buttons.dart';
import 'package:app_vtr/render_video.dart';

Settings settings = Settings();

class Product extends StatelessWidget {
  final String name;
  final String info_text;
  final String link_video;
  final String image;
  final String redirect_product;

  const Product(this.name, this.info_text, this.image, this.link_video, this.redirect_product);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.getColor('background'),
      appBar: Top(),
      body:Center(
        child: Column(
          children: [
            Text(widget.name),
            Image.network(widget.image, height: 100,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(widget.info_text)
            ),
            YoutubePlayerScreen(linkvideo: widget.link_video),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: GestureDetector(
                //onTap: () => ,
                child: const Text('Comprar no site'),
              ),
            )
          ]
        ),
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
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

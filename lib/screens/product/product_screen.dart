import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class ProductScreen extends StatelessWidget {

  final Ad ad;

  ProductScreen(this.ad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anúncio'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            child: Carousel(
                
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:logintest/views/tambahProduk.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TambahProduk()
          ));
        },
      ),
      body: Center(
        child: Text("Product"),
      ),
    );
  }
}

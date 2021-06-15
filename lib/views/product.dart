import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logintest/modal/api.dart';
import 'package:logintest/modal/produkModel.dart';
import 'package:logintest/views/tambahProduk.dart';
import 'package:http/http.dart' as http;

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var loading = false;
  final list = new List<ProdukModel>();
  _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.lihatProduk);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new ProdukModel(
          api['id'],
          api['namaProduk'],
          api['qty'],
          api['harga'],
          api['createdDate'],
          api['idUsers'],
          api['nama'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TambahProduk()));
        },
      ),
      body: loading
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i){
          final x = list[i];
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(x.namaProduk, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                      Text(x.qty),
                      Text(x.harga),
                      Text(x.nama),
                      Text(x.createdDate),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}

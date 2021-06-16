import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logintest/custom/datePicker.dart';
import 'package:logintest/modal/api.dart';
import 'package:logintest/modal/produkModel.dart';

class EditProduk extends StatefulWidget {
  final ProdukModel model;
  final VoidCallback reload;
  EditProduk(this.model, this.reload);
  @override
  _EditProdukState createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final _key = new GlobalKey<FormState>();
  String namaProduk, qty, harga;

  TextEditingController txtNama, txtQty, txtHarga;

  String tgldate;
  setup() {
    tgldate = widget.model.expDate;
    txtNama = TextEditingController(text: widget.model.namaProduk);
    txtQty = TextEditingController(text: widget.model.qty);
    txtHarga = TextEditingController(text: widget.model.harga);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    final response = await http.post(BaseUrl.editProduk, body: {
      "namaProduk": namaProduk,
      "qty": qty,
      "harga": harga,
      "idProduk": widget.model.id,
      "expDate": "$tgldate"
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      setState(() {
        widget.reload();
        Navigator.pop(context);
        print(pesan);
        print(data);
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  String pilihTanggal, labelText;
  DateTime tgl = new DateTime.now();
  var formatTgl = new DateFormat('yyyy-MM-dd');
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));
    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        tgldate = formatTgl.format(tgl);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: txtNama,
              onSaved: (e) => namaProduk = e,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextFormField(
              controller: txtQty,
              onSaved: (e) => qty = e,
              decoration: InputDecoration(labelText: 'Qty'),
            ),
            TextFormField(
              controller: txtHarga,
              onSaved: (e) => harga = e,
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            DateDropDown(
              labelText: labelText,
              valueText: tgldate,
              valueStyle: valueStyle,
              onPressed: () {
                _selectedDate(context);
              },
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

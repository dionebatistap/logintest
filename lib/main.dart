import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username, password;
  final _key = new GlobalKey<FormState>();

//logica para validar os dados antes de salvar
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      //print("$username, $password"); *verificar retorno*
      login();
    }
  }

//Logica para efetuar o login, push no banco de dados
//antes daqui só passa os dados para o androi, depois para a api
  login() async {
    final response = await http.post(
        "http://www.dionebatistap.com.br/login/api/login.php",
        body: {"username": username, "password": password});

    final data = jsonDecode(response.body);
    print(data);
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
              // ignore: missing_return
              validator: (e) {
                if (e.isEmpty) {
                  return "Please insert username";
                }
              },
              onSaved: (e) => username = e,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
            TextFormField(
              obscureText: true,
              onSaved: (e) => password = e,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}

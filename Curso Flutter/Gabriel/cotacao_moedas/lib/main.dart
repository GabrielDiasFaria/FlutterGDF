import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?format=json&key=fe74b834';

void main() async {
  // print(await getData());

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Cotação \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.green,
                  );
                }
            }
          }),
    );
  }
}

Future<Map> getData() async {
  http.Response _response = await http.get(request);
  return json.decode(_response.body);
}

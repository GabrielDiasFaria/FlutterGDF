import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?format=json&key=fe74b834';

void main() async {
  // print(await getData());

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();

  double _usd;
  double _eur;

  void _realChanged(String value){
    double _realDouble = double.parse(value);
    _dolarController.text = (_realDouble / _usd).toStringAsFixed(2);
    _euroController.text = (_realDouble / _eur).toStringAsFixed(2);
  }

  void _clearAll(){
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
  }

  void _dolarChanged(String value){
    double _dolarDouble = double.parse(value);
    _realController.text = (_dolarDouble * _usd).toStringAsFixed(2);
    _euroController.text = (_dolarDouble * _usd / _eur).toStringAsFixed(2);
  }

  void _euroChanged(String value){
    double _euroDouble = double.parse(value);
    _realController.text = (_euroDouble * _eur).toStringAsFixed(2);
    _dolarController.text = (_euroDouble * _eur / _usd).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Cotação \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _clearAll, icon: Icon(Icons.refresh))
        ],
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
                  _usd = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  _eur = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        buildTextField( "Reais", "BRL ", _realController, _realChanged),
                        Divider(),
                        buildTextField( "Dolares", "USD ", _dolarController, _dolarChanged),
                        Divider(),
                        buildTextField( "Euros", "EUR ", _euroController, _euroChanged)
                      ],
                    ),
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

Widget buildTextField(String label, String prefix, TextEditingController controller, Function onChanged){
  return TextField(    
     controller: controller,
      keyboardType: TextInputType.number,                       
      decoration: InputDecoration(                            
          labelText: label,
          labelStyle:
              TextStyle(color: Colors.white, fontSize: 18),
          prefixText: prefix, prefixStyle: TextStyle(color: Colors.white)),
      style: TextStyle(color: Colors.amber, fontSize: 14),
      onChanged: onChanged,
    );
}
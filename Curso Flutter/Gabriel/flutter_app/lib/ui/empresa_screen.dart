import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'http://gdfconsultoria.com.br/GDFApiAdmin/api/GDFAdmin_Empresa';
//const request = 'https://jsonplaceholder.typicode.com/posts';


class empresaScreen extends StatefulWidget {
  @override
  _empresaScreenState createState() => _empresaScreenState();
}

class _empresaScreenState extends State<empresaScreen> {

  List listEmpresas;

  Future<Map> getData() async {
    
    http.Response _response = await http.get(
      Uri.encodeFull(request),
      headers: {"Accept": "application/json"}
    );

    //String jsonString2 = '[{"id":1,"descricao":"Cialne"},{"id":2,"descricao":"Bravo"},{"id":3,"descricao":"CBL"},{"id":4,"descricao":"BSC"},{"id":5,"descricao":"Gabriel"}]';
    //String jsonString = _response.body.toString().replaceAll("\\", "").substring(1, _response.body.toString().replaceAll("\\", "").length - 1 );

    //if (jsonString != jsonString2) {
    //  print("Diferente");
    //  print(jsonString2);
    //  print(jsonString);
    //} else {
    //  print("Igual");
    //}

    //print("Entrando... $jsonString");
    //print(json.decode(jsonString));
    setState(() {
      listEmpresas = json.decode(_response.body.toString().replaceAll("\\", "").substring(1, _response.body.toString().replaceAll("\\", "").length - 1 ));
    });

    return Map();
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empresas"),
         backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: listEmpresas == null ? 0 : listEmpresas.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Text(listEmpresas[index]["descricao"].toString()),
            
          );
        },
      ),
    );
  }
}
//child: Text(listEmpresas[index]["title"]),
//Future<Map> getData() async {
//  http.Response _response = await http.get(request);
//  //print(_response.body.toString().replaceAll("\\", ""));
//  return json.decode(_response.body.replaceAll("\\", ""));
//}
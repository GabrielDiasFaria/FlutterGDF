import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:listajsonnew/EmpresaModel.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _urlBase = "http://gdfconsultoria.com.br/GDFApiAdmin/api/GDFAdmin_Empresa";

  Future<List<EmpresaModel>> _getEmpresa() async {

    http.Response response = await http.get(_urlBase);
    var dadosJson = json.decode(response.body.toString().replaceAll("\\", "").substring(1, response.body.toString().replaceAll("\\", "").length - 1 ));

    List<EmpresaModel> empresas = List();

    for( var post in dadosJson){
      EmpresaModel p = EmpresaModel(post["id"],post["descricao"]);
      empresas.add(p);
    }

    return empresas;
  }

  _postEmpresa() async {

//     var _corpo = json.encode(
//       {"id":0,"descricao":"Novo Recurso"}
//     );
//
//     http.Response response =  await http.post(
//     _urlBase,
//     headers: {
//       "Content-type": "application/json",
//       "Request-From": "POST"
//     },
//     body: _corpo
//     );
//
//     int statusCode = response.statusCode;
//     print("Send: $statusCode");
//
//     var responseJson = json.decode(response.body.toString().replaceAll("\\", "").substring(1, response.body.toString().replaceAll("\\", "").length - 1 ));
//
//     print("Body:"+ responseJson["message"]);
//
//     return responseJson["message"];

  }

  _putEmpresa(){

  }

  _delEmpresa(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Consumindo Serviço HTTP"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
            Row(
               children: <Widget>[
                 RaisedButton(child: Text("Criar"),
                 onPressed: _postEmpresa(),
                 ),
                 RaisedButton(child: Text("Atualizar"),
                 onPressed: _putEmpresa(),
                 ),
                 RaisedButton(child: Text("Deletar"),
                 onPressed: _delEmpresa(),
                 )
               ],
             ),
              Expanded(
                child: FutureBuilder<List<EmpresaModel>>(
                  future: _getEmpresa(),
                  builder: (context, snapshot){
                    switch (snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if(snapshot.hasError){
                          print("Erro!");
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              List<EmpresaModel> lista = snapshot.data;
                              EmpresaModel empresa = lista[index];
                              return ListTile(
                                title: Text(empresa.id.toString()),
                                subtitle: Text(empresa.descricao),
                              );
                            }
                          );
                        }
                    }
                  }
                ),
              )
            ],
          ),
        )
    );
  }
}
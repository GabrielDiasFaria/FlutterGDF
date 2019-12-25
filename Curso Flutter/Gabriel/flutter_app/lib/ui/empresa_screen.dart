import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';

const request = 'http://gdfconsultoria.com.br/GDFApiAdmin/api/GDFAdmin_Empresa';
//const request = 'https://jsonplaceholder.typicode.com/posts';

List listEmpresas;
String  id_empresa_click, descricao_empresa_click;
final   descricaoController = TextEditingController();

class empresaScreen extends StatefulWidget {
  @override
  _empresaScreenState createState() => _empresaScreenState();
}

class _empresaScreenState extends State<empresaScreen> {
  
  Future<Map> getData() async {
    
    http.Response _response = await http.get(
      Uri.encodeFull(request),
      headers: {"Accept": "application/json"}
    );

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
            child: buildCadEmpresa(context, index),
            
          );
        },
      ),
    );
  }
}

Widget buildCadEmpresa(BuildContext context, int index){
 return new Slidable(
   actionPane: SlidableDrawerActionPane(),
   actionExtentRatio: 0.25,
   child: new Container(
    color: Colors.white,
    child: new ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.indigo,
        child: new Text(listEmpresas[index]["descricao"].toString().substring(0,1)),
        foregroundColor: Colors.white,
      ),
      title: new Text("#" + listEmpresas[index]["id"].toString()),
      subtitle: new Text(listEmpresas[index]["descricao"].toString()),
    ),
  ),
  actions: <Widget>[
     new IconSlideAction(
      caption: 'Edit',
      color: Colors.blue,
      icon: Icons.edit,
      onTap: () {
        id_empresa_click         = listEmpresas[index]["id"].toString();
        descricao_empresa_click  = listEmpresas[index]["descricao"].toString();
        descricaoController.text = listEmpresas[index]["descricao"].toString();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditRoute()),
        );
      },
    )
  ],
  secondaryActions: <Widget>[
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () {
        id_empresa_click        = listEmpresas[index]["id"].toString();
        descricao_empresa_click = listEmpresas[index]["descricao"].toString();
        showDialogDelete(context);
      },
    )
  ],
 );
}

void showDialogDelete(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Deseja realmente deletar?"),
          content: Text("Empresa: " + id_empresa_click),
          actions: <Widget>[
            new FlatButton(
              child: Icon(Icons.delete, color: Colors.red,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Icon(Icons.cancel, color: Colors.blue,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),     
          ],
        );
      }
    );
  }

class EditRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Empresa: " + id_empresa_click),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
          child: Container( 
            child: Column(            
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: new CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: new Text(id_empresa_click),
                    foregroundColor: Colors.white,
                  ),
                  title: new Text("Empresa " + id_empresa_click),
                ),
                TextField(    
                  controller: descricaoController,         
                  decoration: InputDecoration(                    
                    hintText: descricao_empresa_click                    
                  ),
                ),
                FlatButton( 
                  child: Text("Salvar", textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo),),
                  onPressed: (){
                    modifyData(context);
                    Navigator.of(context).pop();
                  }
                ) 
              ],
            ),
            ),
        )
    );
  }
}

void modifyData(BuildContext context) async{

  // listEmpresas;
  // id_empresa_click, descricao_empresa_click;

  print("Entrou...");

  Map<String, String> headers = {
    "Content-type": "application/json",
    "Request-From": "PUT"
  };

  print("Controller: $id_empresa_click,  $descricaoController");

  String _json = '{"id": "$id_empresa_click", "descricao": "' + descricaoController.text + '"}';

  Response _response = await post(request, headers: headers, body: _json);

  int statusCode = _response.statusCode;

  print("Send: $statusCode");

  Map<String, dynamic> body = json.decode(_response.body.toString().replaceAll("\\", "").substring(1, _response.body.toString().replaceAll("\\", "").length - 1 ));

  print("Body:"+ body["message"]);

  descricaoController.text = "";

  //showToast(context);
}

void showToast(BuildContext context){
  Fluttertoast.showToast(
      msg: "This is Toast messaget",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1
  );
}

//Widget buildCadEmpresa(int index){
// return new Text(listEmpresas[index]["descricao"].toString());
//}
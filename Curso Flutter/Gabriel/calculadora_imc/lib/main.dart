import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _alturaController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe Seus Dados";

  void _resetFields() {
    _alturaController.text = "";
    _pesoController.text = "";

    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    setState(() {
      double _peso = double.parse(_pesoController.text);
      double _altura = double.parse(_alturaController.text) / 100;
      double _imc = _peso / (_altura * _altura);

      if (_imc < 18.6) {
        _infoText = "Abaixo do peso (IMC - ${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 18.6 && _imc < 24.9) {
        _infoText = "Peso Ideal (IMC - ${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 24.9 && _imc < 29.9) {
        _infoText = "Levemente acima (IMC - ${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 29.9 && _imc < 34.9) {
        _infoText = "Obesidade Grau 1 (IMC - ${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 34.9 && _imc < 39.9) {
        _infoText = "Obesidade Grau 2 (IMC - ${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 40) {
        _infoText = "Obesidade Grau 3 (IMC - ${_imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (KG)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: _pesoController,
                  validator: (value) {
                    return value.isEmpty ? 'Informar Peso' : null;
                  },
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (CM)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: _alturaController,
                    validator: (value) {
                      return value.isEmpty ? 'Informar Altura' : null;
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()) _calculateIMC();
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20),
                )
              ],
            ),
          ),
        ));
  }
}

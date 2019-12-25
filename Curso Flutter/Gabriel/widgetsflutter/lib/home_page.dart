import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello - Primeiro"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body(){
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _text(),
          _pageView(),
          _buttons()
        ],
      ),
    );
  }

  _pageView(){
    return Container(
      height: 300,
      margin: EdgeInsets.all(16),
      child: PageView(
        children: <Widget>[
          _img("1"),
          _img("2"),
          _img("3"),
          _img("4"),
          _img("5"),
        ],
      ),
    );
  }

  _buttons() {
    return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("ListView"),
                _button("Page 2"),
                _button("Page 3")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("Snack"),
                _button("Dialog"),
                _button("Toast")
              ],
            )
          ],
        );
  }

  _button(String msg){
    return RaisedButton(
      color: Colors.blue,
      child: Text(
          msg,
          style: TextStyle(
            color: Colors.white
          ),
      ),
      onPressed: (){ print("Ok"); },
    );
  }

  _img(String dog){
    return Image.asset(
      "assets/img/dog${dog}.png",
      fit: BoxFit.cover,
    );
  }

  _text(){
    return Text(
      "Texto Decorado",
      style: TextStyle(
          color: Colors.blue,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationStyle: TextDecorationStyle.wavy
      ),
    );
  }

}
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Counter Persons",
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _person = 0;

  void _setPerson(int value){
    setState(() {
      _person += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/bg.jpg",
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Persons $_person",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text("Add", style: TextStyle(color: Colors.white),),
                    onPressed: (){ _setPerson(1); },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text("Remove", style: TextStyle(color: Colors.white),),
                    onPressed: (){ _setPerson(-1); },
                  ),
                ),
              ],
            ),
            Text(
              "Come in",
              style: TextStyle(
                  color: Colors.white, fontStyle: FontStyle.italic, fontSize: 30),
            )
          ],
        )
      ],
    );
  }
}

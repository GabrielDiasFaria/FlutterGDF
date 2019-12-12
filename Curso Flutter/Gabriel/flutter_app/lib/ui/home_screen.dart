import 'package:flutter/material.dart';
import 'empresa_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pole Alimentos'),
        backgroundColor: Colors.indigo,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              accountName: Text("Gabriel Dias"),
              accountEmail: Text("gabrieldiasfaria@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
              ),
            ),
            ListTile(
              title: Text('Empresa'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => empresaScreen()
                ));
              },
            ),
            ListTile(
              title: Text('Módulos'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
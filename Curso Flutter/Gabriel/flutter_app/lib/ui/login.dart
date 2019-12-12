import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginScreen> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', 
      fontSize: 20.0, 
      color: Colors.white,
      decorationColor: Colors.white
    );

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.indigo,
      child: MaterialButton(        
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(
            context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()
            ),
          );
        },
        child: Text("Acessar",            
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),                
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(          
          //color: Colors.white,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.orange[900],
                      Colors.pink
                    ],
                  )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "lib/assets/Pole.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
              ],
            ),
          ),
        ),
      ),
        );
  }
}
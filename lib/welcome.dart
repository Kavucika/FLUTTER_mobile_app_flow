import 'package:flutter/material.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor : Colors.black,
      body:Center(
            child: Image.asset(
              "assets/image/panda img.jpg",
              width:450,
              height:450,
            ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_circle_right_outlined,
            color: Colors.blueAccent,
          ),
          backgroundColor: Colors.black,
          onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
          }
      ),
    );
  }
}
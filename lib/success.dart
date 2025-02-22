import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget{
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>{
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
    home: Scaffold(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkTheme ? Colors.black : Colors.blueGrey,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
          },
        ),
        actions: [
          IconButton(
            icon:Icon(
              Icons.person_pin,
            ),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isDarkTheme = !isDarkTheme;
              });
            },
          ),
        ],
      ),
      body:Center(
        child:Text(
              "You have logged in successfully...!!",
              style:TextStyle(
                color: isDarkTheme ? Colors.white54 : Colors.black54,
                fontSize: 16,
              ),
        ),
      ),
    ),
    );
  }
}
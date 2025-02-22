import 'package:flutter/material.dart';
import 'signup.dart';
import 'success.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> login(String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("User logged in: ${userCredential.user?.email}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user found for that email. Please sign up.')),
      );
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect password. Please try again.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.message}')),
      );
    }
  } catch (e) {
    print("Error: $e");
  }
}

class LoginPage extends StatefulWidget{
  final bool isSignupSuccess;

  LoginPage({this.isSignupSuccess = false});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isValidEmail = true;
  String emailError = '';
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.isSignupSuccess) {
      _showSuccessMessage = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_showSuccessMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully signed up. Please login to continue')),
          );
          setState(() {
            _showSuccessMessage = false;
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blueAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Center(
        child:SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children :[
            Image.asset("assets/image/panda img.jpg",
            height: 300,
            width:300,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person_rounded),
                      labelStyle: TextStyle(color: Colors.white),
                      border:OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      color: Colors.white, // Color of the text entered by the user
                    ),
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_rounded),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      errorText: isValidEmail ? null : emailError,
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        isValidEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(value);
                        emailError =
                        isValidEmail ? '' : 'Please enter a valid email';
                      });
                    },
                  ),

                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText:"Password",
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      labelStyle: TextStyle(color:Colors.white),
                      border:OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  ElevatedButton(
                      onPressed:()async {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Fields cannot be empty')),
                          );
                          return;
                        }
                        if (!isValidEmail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Enter a valid email')),
                          );
                          return;
                        }
                        await login(
                            emailController.text, passwordController.text, context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor : Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                  ),

                  SizedBox(height: 150),

                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      "Create new Account",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor : Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal:45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
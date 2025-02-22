import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signUp(String email, String password,BuildContext context) async {
  try {
    if (password.length < 6) {
      throw FirebaseAuthException(
        code: 'weak-password',
        message: 'Password must be at least 6 characters long.',
      );
    }
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("User signed up: ${userCredential.user?.email}");
  } on FirebaseAuthException catch (e) {
    String errorMessage = 'Sign-up failed';

    if (e.code == 'email-already-in-use') {
      errorMessage = 'This email is already registered. Please login.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'Invalid email format.';
    } else if (e.code == 'weak-password') {
      errorMessage = e.message ?? 'Password must be at least 6 characters.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
    throw e; // Stop execution if an error occurs
  }
}

class SignupPage extends StatefulWidget{
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>{
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isValidEmail = true;
  String emailError = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.purple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Padding(
        padding:EdgeInsets.all(20.0),
        child:SingleChildScrollView(
        child:Column(
        children: [
          SizedBox(height:20),
          Text(
            "What's your email address?",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 25,
            ),
          ),
          SizedBox(height:20),
          Text(
            "Enter the email address at which you can be contacted. No one will see this on your profile.",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 15,
            ),
          ),
          SizedBox(height:15),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: "Enter your user name",
              labelStyle: TextStyle(color: Colors.white54),
              border:OutlineInputBorder() ,
            ),
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          SizedBox(height:15),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter your email address",
              labelStyle: TextStyle(color: Colors.white54),
              border:OutlineInputBorder() ,
              errorText: isValidEmail ? null : emailError,
            ),
            style: TextStyle(
              color: Colors.white54,
            ),
            onChanged: (value) {
              setState(() {
                isValidEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value);
                emailError = isValidEmail ? '' : 'Please enter a valid email';
              });
            },
          ),
          SizedBox(height:15),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Enter your password",
              labelStyle: TextStyle(color: Colors.white54),
              border:OutlineInputBorder() ,
            ),
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          SizedBox(height:15),
          ElevatedButton(
              onPressed: ()async {
                if (usernameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fields cannot be empty')),
                  );
                  return;
                }
                if (passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password must be at least 6 characters')),
                  );
                  return;
                }
                if (!isValidEmail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enter a valid email')),
                  );
                  return;
                }
                try {
                  await signUp(emailController.text, passwordController.text,context);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(isSignupSuccess: true)),
                  );
                } catch (e) {
                }
              },
              child: Text(
                "Sign Up",
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              "Already have an Account",
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
      ),
    );
  }
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
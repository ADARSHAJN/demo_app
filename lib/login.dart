import 'package:demo_app/CustomNavigator.dart';
import 'package:demo_app/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'movie.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('User Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 350,
                child: Image.network(
                    "https://images-platform.99static.com//CrN0M6KwHq3-UGqGiKJG7VgrDGQ=/257x0:1497x1240/fit-in/500x500/99designs-contests-attachments/32/32513/attachment_32513332"),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.white,
                elevation: 1,
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First name';
                      } else if (value.length > 50) {
                        return 'First name must be up to 50 characters';
                      }
                      return null;
                    },
                    autofocus: false,
                    controller: emailController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Email',
                      focusColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orangeAccent,
                      ),
                    )),
              ),
              SizedBox(height: 12.0),
              Card(
                color: Colors.white,
                elevation: 1,
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length > 50) {
                        return 'First name must be up to 50 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      focusColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.password_rounded,
                        color: Colors.orangeAccent,
                      ),
                    )),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Authentication successful, navigate to next screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => CustomBottomNavBar()));
                    } catch (e) {
                      // Authentication failed, show error message
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Invalid Credentials'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text("Dont have an account? "),
                InkWell(
                  child: Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent),),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SignupScreen()));
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

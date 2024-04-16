import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';


class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<String> professions = ['Engineer', 'Doctor', 'Teacher', 'Other'," "];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('User Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  backgroundColor:Colors.transparent,
                  radius: 60,
                  child: Icon(
                      size: 120,
                      Icons.account_circle)),
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
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Name',
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.orangeAccent,
                    ),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email',
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.orangeAccent,
                    ),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Phone Number';
                    }
                    return null;
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Phone Number',
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.orangeAccent,
                    ),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Profession",
                  focusColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.work_history_outlined,
                    color: Colors.orangeAccent,
                  ),
                ),
                icon: Icon(
                  Icons.work_history,
                  color: Colors.orangeAccent,
                ),
                items: professions.map((String profession) {
                  return DropdownMenuItem<String>(
                    value: profession,
                    child: Text(profession),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
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

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('name', nameController.text);
                  await prefs.setString('password', passwordController.text);
                  await prefs.setString('email', emailController.text);
                  await prefs.setString('phone', phoneController.text);
                  // You can also save profession here
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                  createUser(emailController.text,passwordController.text,nameController.text);
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
                  ),
      ),
    );
  }
  void createUser(email,password,name)async{
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(credential);
      var user = credential.user;
      print(user);
      if (user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);
        String photoUrl = "https://cdn-icons-png.flaticon.com/512/2342/2342004.png";

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBar( content: Text("the password provided is too weak"),);
      } else if (e.code == 'email-already-in-use') {
        SnackBar(content:Text("the email is already in use") );
      } else if (e.code == 'invalid-email') {
        const SnackBar(content: Text("your email id is invalid"));
      }
    }
  }
}

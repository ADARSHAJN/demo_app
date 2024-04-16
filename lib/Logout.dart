import 'package:demo_app/login.dart';
import 'package:demo_app/sign_up.dart';
import 'package:flutter/material.dart';

import 'AppDrawer.dart';
import 'CustomNavigator.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:DrawerPage(),

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              size: 100,
              color: Colors.orangeAccent,
            ),
            SizedBox(height: 20),
            Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                showAlertDialog(context);
               // Pop the logout screen
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK",
          style: TextStyle(color:Colors.orangeAccent)),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) =>LoginScreen()));
      },
    );
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.orangeAccent),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      elevation: 0,
      title: Text("Logout Application"),
      content: Text("Sure want to Logout?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}




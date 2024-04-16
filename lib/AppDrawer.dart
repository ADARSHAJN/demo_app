import 'package:flutter/material.dart';
import 'package:demo_app/movie.dart';
import 'package:demo_app/myspace.dart';

import 'Logout.dart';
// Import your settings screen

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Drawer(
        backgroundColor: Colors.white,
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Movie List'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MovieListPage()),
                );
              },
            ),
            ListTile(
              title: Text('My Space'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MySpace()),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Logout()),
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}




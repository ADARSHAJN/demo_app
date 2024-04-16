import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppDrawer.dart';
import 'CustomNavigator.dart';

class MySpace extends StatelessWidget {
  const MySpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:DrawerPage(),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('MySpace'),
        )
    );
  }
}

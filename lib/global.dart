import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class Global {


  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    Platform.isAndroid
        ? await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyAp0Kw8b48oLXUZi7sHTzBp7jC6-pH-_v0',
            appId: '1:90387104969:android:bd73e9f3f6485a83823918',
            messagingSenderId: '90387104969',
            projectId: 'mobile-app-5e956'))
        : await Firebase.initializeApp();

  }
}
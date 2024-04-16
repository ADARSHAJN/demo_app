import 'package:demo_app/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'login.dart'; // Import your sign-up screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Demo App",style: TextStyle(fontSize:30,
              fontWeight: FontWeight.bold,),)
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    handleScreen();
    // Check authentication state when the widget initializes

  }
  Future<void> handleScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is already authenticated, navigate to login screen or home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen
        );
      } else {
        // No user is authenticated, navigate to sign-up page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignupScreen()), // Replace with your sign-up screen
        );
      }
    });
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/screens/home.dart';
import 'package:sampleecom/screens/login.dart';
import 'package:sampleecom/screens/tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
    } else {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Hero(
              tag: "logo-shift", child: Image.asset('assets/images/logo.png')),
        ));
  }
}

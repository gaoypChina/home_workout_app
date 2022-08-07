import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'login_page/login_page.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(Duration(seconds: 0));
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage(index: 0)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff192028),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Home ".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Theme.of(context).primaryColor,
                        fontSize: 32)),
                TextSpan(
                    text: "Workout".toUpperCase(),
                    style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 32))
              ])),
              SizedBox(
                height: 28,
              ),
              Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white60,
                  ))
            ],
          ),
        ));
  }
}

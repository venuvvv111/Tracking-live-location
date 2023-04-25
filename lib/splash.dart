// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

import 'package:tracker/screens/first.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      print("After 2 seconds");
      //This block of code will execute after 3 sec of app launch
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const First()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,

            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("images/background.gif"),
                fit: BoxFit.contain,
              ),
            ),

            // child: Container(
            //   height: 50,
            //   width: 50,
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //   child: Image(
            //     image: AssetImage('images/logo.jpg'),
            //     fit: BoxFit.scaleDown,
            //   ),
            // ),
          ),
          Center(
            child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(),
                child: const Image(image: AssetImage('images/logo.png'))),
          )
        ]),
      ),
    );
  }
}

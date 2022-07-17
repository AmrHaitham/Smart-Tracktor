import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_tracktor/MainScreen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Automatic Electric Tractor'))
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:const AssetImage("assets/pattern.jpg"),
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.05), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin:const EdgeInsets.only(top: 35),
                      width:200,
                      height:200,
                      child: Image.asset("assets/logo.png")
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/auth/api_service.dart';
import 'package:project/screens/homescreen.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/theme/theme_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () {
        ApiService.getdata('ID').then((userid) {
          print(userid);
          if (userid != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Container(
              height: 72,
              child: SvgPicture.asset("assets/image/logo.svg"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/screens/singnup.dart';
import 'package:project/screens/splashscreen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginScreen = '/login_screen';

  static const String Signup = '/signup_screen';
  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    loginScreen: (context) => LoginScreen(),
    Signup: (context) => SignupScreen(),
    };
  }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:project/screens/splashscreen.dart';
import 'package:project/theme/theme_helper.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      title: 'RAQAMAK VIP',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: AppRoutes.routes,
    );
  }
}

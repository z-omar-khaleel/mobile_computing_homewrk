import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/login.dart';

import 'controller.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              bodyText2: TextStyle(fontSize: 16, color: Colors.blue))),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer x;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    x.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    x = Timer(const Duration(seconds: 3), () => Get.off(() => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final x = Get.put(ControllerApp());
    return const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Image(
            width: 130,
            height: 130,
            image: AssetImage("assets/images/splash.png"),
          ),
        ));
  }
}

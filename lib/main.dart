import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/login.dart';

import 'controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
            image: AssetImage("assets/images/splash.png"),
          ),
        ));
  }
}

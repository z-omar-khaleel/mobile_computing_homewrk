import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/utils/constant.dart';
import 'package:mobile_computing_homework/screens/login.dart';
import 'package:mobile_computing_homework/utils/sharePref.dart';

import 'controller/controller.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final ref = await Get.put(ControllerApp());
  userId = await SharePref.getData(key: 'user');
  if (userId != null) {
    ref.getUserData();
    ref.fetchRecords();
    ref.fetchFood();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.blue,
          ),
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
    x = Timer(const Duration(seconds: 3), () {
      if (userId == null) {
        Get.off(() => LoginScreen());
      } else {
        Get.off(() => HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

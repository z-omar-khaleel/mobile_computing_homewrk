import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/sign_up.dart';

class ControllerApp extends GetxController {
  final formKey = GlobalKey<FormState>();
  var userController = TextEditingController();
  var passController = TextEditingController();

  validateLogin() {
    if (formKey.currentState!.validate()) {
      Get.to(SignUp());
    }
  }
}

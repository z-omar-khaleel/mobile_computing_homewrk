import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/login.dart';
import 'package:mobile_computing_homework/sign_up.dart';

class ControllerApp extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  var userController = TextEditingController();
  var userNameController = TextEditingController();
  var passController = TextEditingController();
  var passRegisterController = TextEditingController();
  var emailController = TextEditingController();
  var rePassController = TextEditingController();
  var isPass = true;
  changVisability() {
    isPass = !isPass;
    update();
  }

  validateLogin() {
    if (formKey.currentState!.validate()) {
      Get.to(SignUp());
    }
  }

  validateRegister() {
    if (formKeyRegister.currentState!.validate()) {}
  }
}

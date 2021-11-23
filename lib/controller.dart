import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_computing_homework/info_screen.dart';
import 'package:mobile_computing_homework/sign_up.dart';

class ControllerApp extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  var userController = TextEditingController();
  var dateController = TextEditingController();
  var weightController = TextEditingController(text: '0');
  String gender = 'Male';

  var heightController = TextEditingController(text: '0');
  var userNameController = TextEditingController();
  var passController = TextEditingController();
  var passRegisterController = TextEditingController();
  var emailController = TextEditingController();
  var rePassController = TextEditingController();
  var isPass = true;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  changVisability() {
    isPass = !isPass;
    update();
  }

  changeSelectedDate(DateTime time) {
    selectedDate.value = time;
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  validateLogin() {
    if (formKey.currentState!.validate()) {
      Get.offAll(InfoScreen());
    }
  }

  validateRegister() {
    if (formKeyRegister.currentState!.validate()) {
      Get.offAll(InfoScreen());
    }
  }

  changeGender(String val) {
    gender = val;
    update();
  }
}

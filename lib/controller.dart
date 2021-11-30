import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_computing_homework/info_screen.dart';

class ControllerApp extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  var userController = TextEditingController();
  var dateController = TextEditingController();
  var weightController = TextEditingController(text: '10');
  String gender = 'Male';
  bool fromRegister = false;

  var heightController = TextEditingController(text: '100');
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
      fromRegister = false;

      Get.offAll(InfoScreen());
    }
  }

  validateRegister() {
    if (formKeyRegister.currentState!.validate()) {
      Get.offAll(InfoScreen());
      fromRegister = true;
    }
  }

  changeGender(String val) {
    gender = val;
    update();
  }

  closeAllController() {
    userController.clear();
    dateController.clear();
    weightController.text = '10';
    heightController.text = '100';
    userNameController.clear();
    passController.clear();
    passRegisterController.clear();
    emailController.clear();
    rePassController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    closeAllController();
  }
}

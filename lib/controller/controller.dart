import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_computing_homework/models/food_model.dart';
import 'package:mobile_computing_homework/models/record_info.dart';
import 'package:mobile_computing_homework/models/user_info.dart';
import 'package:mobile_computing_homework/screens/info_screen.dart';
import 'package:mobile_computing_homework/utils/constant.dart';
import 'package:mobile_computing_homework/utils/sharePref.dart';

enum BMI { Underweight, HealthyWeight, Overweight, Obesity }

class ControllerApp extends GetxController {
  final formKey = GlobalKey<FormState>();
  List<RecordInfo> records = [];
  List<FoodModel> foods = [];
  UserInformation? userInformation;
  final formKeyRegister = GlobalKey<FormState>();
  var userController = TextEditingController();
  var dateController = TextEditingController();
  var weightController = TextEditingController(text: '10');
  String gender = 'Male';
  String bmiStatus = 'HealthyWeight';
  double? bmi;
  XFile? imagePicked;

  var heightController = TextEditingController(text: '100');
  var userNameController = TextEditingController();
  var nameFoodController = TextEditingController();
  var categoryFoodController = TextEditingController();
  var caloryFoodController = TextEditingController();
  var passController = TextEditingController();
  var passRegisterController = TextEditingController();
  var emailController = TextEditingController();
  var rePassController = TextEditingController();
  var isPass = true;
  int age = 0;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  changVisability() {
    isPass = !isPass;
    update();
  }

  changeSelectedDate(DateTime time) {
    selectedDate.value = time;
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    update();
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 350,
        maxWidth: 550);

    imagePicked = image;
    update();
  }

  fetchFood() async {
    foods = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Foods')
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((e) {
        foods.add(FoodModel.fromMap(e.data()));
      });
    });
    update();
  }

  uploadFood(FoodModel model) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Foods')
        .doc()
        .set(model.toMap())
        .then((value) {
      fetchFood();
      Get.back();
    });
    update();
  }

  validateLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: userController.text, password: passController.text)
            .then((value) async {
          SharePref.setData(key: 'user', data: value.user!.uid)
              .then((value) async {
            if (value) {
              await getUserData();

              Get.offAll(InfoScreen());
            } else {
              Get.snackbar('Error', 'Error in store data');
            }
          });
          print(value.user!.email);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Wrong password provided for that user.');
        }
      }
      update();
    }
  }

  addRecord(RecordInfo record) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Records')
        .doc()
        .set(record.toMap())
        .then((value) {
      fetchRecords();
    });
    update();
  }

  fetchRecords() async {
    records = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Records')
        .orderBy('dateTime')
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((e) {
        records.add(RecordInfo.fromMap(e.data()));
      });
      if (records.isNotEmpty) {
        bmiStatus = records.first.status;
        print(records.first.dateTime);
      }
      ;
    });
    update();
  }

  createUser(
      {required String email, required String name, required String id}) async {
    final user = UserInformation(email: email, name: name, id: id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(user.toJson())
        .then((value) async {
      SharePref.setData(key: 'user', data: id).then((value) async {
        if (value) {
          await getUserData();

          Get.offAll(InfoScreen());
        } else {}
      });
    }).catchError((error) {});
  }

  validateRegister() async {
    if (formKeyRegister.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text,
                password: passRegisterController.text)
            .then((value) => createUser(
                email: userController.text,
                name: userNameController.text,
                id: value.user!.uid));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Password', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Account', 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }

      update();
    }
  }

  changeGender(String val) {
    gender = val;
    update();
  }

  double findPercentage(int age) {
    if (age >= 2 && age < 10) {
      return .7;
    } else if (age >= 10 && age <= 20) {
      if (gender == 'Male') {
        return .9;
      } else {
        return .8;
      }
    }
    return 1;
  }

  classifyBmi(double val) {
    if (val < 18.5) {
      bmiStatus = 'Underweight';
    } else if (val >= 18.5 && val < 25) {
      bmiStatus = 'HealthyWeight';
    } else if (val >= 25 && val < 30) {
      bmiStatus = 'Overweight';
    } else {
      bmiStatus = 'Obesity';
    }
  }

  findBmi() {
    age = DateTime.now().year - selectedDate.value.year;
    double agePercentage = findPercentage(age);
    print(weightController.text);
    double weight = double.parse(weightController.text);
    double height = double.parse(
        (double.parse(heightController.text) / 100).toStringAsFixed(3));
    print(height);
    print(weight / (height * height));
    bmi = double.parse(
        (weight / (height * height) * agePercentage).toStringAsFixed(1));
    classifyBmi(bmi!);
    addRecord(RecordInfo(
      bmi: bmi!,
      height: double.parse(heightController.text),
      weight: weight,
      dateTime: DateFormat('yyyy-MM-dd').format(selectedDate.value),
      status: bmiStatus,
    ));
    update();
  }

  closeAllController() {
    nameFoodController.clear();
    caloryFoodController.clear();
    categoryFoodController.clear();
    userController.clear();
    dateController.clear();
    weightController.text = '10';
    heightController.text = '100';
    userNameController.clear();
    passController.clear();
    passRegisterController.clear();
    emailController.clear();
    rePassController.clear();
    SharePref.removeKey('user');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (userId != null) {
      getUserData();
      fetchRecords();
    }
  }

  getUserData() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        userInformation = UserInformation.fromJson(value.data()!);
      });
    } catch (e) {}
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    closeAllController();
  }
}

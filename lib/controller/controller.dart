import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_computing_homework/models/food_model.dart';
import 'package:mobile_computing_homework/models/record_info.dart';
import 'package:mobile_computing_homework/models/user_info.dart';
import 'package:mobile_computing_homework/screens/home_screen.dart';
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
  String? bmiCondition;
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
  Rx<DateTime> selectedNewDate = DateTime.now().obs;
  changVisability() {
    isPass = !isPass;
    update();
  }

  changeSelectedDate(DateTime time) {
    selectedDate.value = time;
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    update();
  }

  changeNewSelectedDate(DateTime time) {
    selectedNewDate.value = time;
    dateController.text =
        DateFormat('yyyy-MM-dd').format(selectedNewDate.value);
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
      value.docs.forEach((e) {
        foods.add(FoodModel.fromMap(e.data()));
      });
      update();
    });
  }

  updateUserInformation(int age, String gender) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'gender': gender, 'age': age});
    await getUserData();
    update();
  }

  deleteFood(FoodModel model) async {
    final ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Foods')
        .doc(model.id)
        .delete();
    await fetchFood();
    update();
  }

  uploadFood(FoodModel model) async {
    final ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Foods')
        .doc();
    ref.set({
      'name': model.name,
      'category': model.category,
      'photo': model.photo,
      'id': ref.id,
      'calory': model.calory,
    }).then((value) async {
      await fetchFood();
      Get.back();
      update();
    });
  }

  updateFood(FoodModel model, String id) async {
    final ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Foods')
        .doc(id);
    ref.update({
      'name': model.name,
      'category': model.category,
      'photo': model.photo,
      'id': ref.id,
      'calory': model.calory,
    }).then((value) async {
      await fetchFood();
      Get.back();
      update();
    });
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

              Get.offAll(HomeScreen());
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
      update();
    });
  }

  findDifference() {
    if (records.length > 1) {
      double diff =
          double.parse((records[1].bmi - records[0].bmi).toStringAsFixed(1));
      print('dii$diff');
      if (records.first.status == 'Underweight') {
        if (diff < -1) {
          bmiCondition = 'So Bad';
        } else if (diff >= -1 && diff < -.6) {
          bmiCondition = 'So Bad';
        } else if (diff >= -.6 && diff < -.3) {
          bmiCondition = 'So Bad';
        } else if (diff >= -.3 && diff < 0) {
          bmiCondition = 'Little Changes';
        } else if (diff >= 0 && diff < .3) {
          if (diff == 0.0) {
            bmiCondition = 'Still Good';
          } else {
            bmiCondition = 'Little Changes';
          }
        } else if (diff >= .3 && diff < .6) {
          bmiCondition = 'Still Good';
        } else if (diff >= .6 && diff < 1) {
          bmiCondition = 'Go Ahead';
        } else {
          bmiCondition = 'Go Ahead';
        }
      } else if (records.first.status == 'HealthyWeight') {
        if (diff < -1) {
          bmiCondition = 'So Bad';
        } else if (diff >= -1 && diff < -.6) {
          bmiCondition = 'Be Careful';
        } else if (diff >= -.6 && diff < -.3) {
          bmiCondition = 'Be Careful';
        } else if (diff >= -.3 && diff < 0) {
          bmiCondition = 'Little Changes';
        } else if (diff >= 0 && diff < .3) {
          if (diff == 0) {
            bmiCondition = 'Still Good';
          } else {
            bmiCondition = 'Little Changes';
          }
        } else if (diff >= .3 && diff < .6) {
          bmiCondition = 'Be Careful';
        } else if (diff >= .6 && diff < 1) {
          bmiCondition = 'Be Careful';
        } else {
          bmiCondition = 'Be Careful';
        }
      } else if (records.first.status == 'Overweight') {
        if (diff < -1) {
          bmiCondition = 'Be Careful';
        } else if (diff >= -1 && diff < -.6) {
          bmiCondition = 'Go Ahead';
        } else if (diff >= -.6 && diff < -.3) {
          bmiCondition = 'So Bad';
        } else if (diff >= -.3 && diff < 0) {
          bmiCondition = 'Little Changes';
        } else if (diff >= 0 && diff < .3) {
          if (diff == 0) {
            bmiCondition = 'Still Good';
          } else {
            bmiCondition = 'Little Changes';
          }
        } else if (diff >= .3 && diff < .6) {
          bmiCondition = 'Be Careful';
        } else if (diff >= .6 && diff < 1) {
          bmiCondition = 'So Bad';
        } else {
          bmiCondition = 'So Bad';
        }
      } else {
        if (diff < -1) {
          bmiCondition = 'Go Ahead';
        } else if (diff >= -1 && diff < -.6) {
          bmiCondition = 'Go Ahead';
        } else if (diff >= -.6 && diff < -.3) {
          bmiCondition = 'Little Changes';
        } else if (diff >= -.3 && diff < 0) {
          bmiCondition = 'Little Changes';
        } else if (diff >= 0 && diff < .3) {
          if (diff == 0) {
            bmiCondition = 'Still Good';
          } else {
            bmiCondition = 'Be Careful';
          }
        } else if (diff >= .3 && diff < .6) {
          bmiCondition = 'So Bad';
        } else if (diff >= .6 && diff < 1) {
          bmiCondition = 'So Bad';
        } else {
          bmiCondition = 'So Bad';
        }
      }
    } else {
      bmiCondition = 'Still Good';
    }
  }

  fetchRecords() async {
    records = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Records')
        .orderBy('dateTime', descending: true)
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
      findDifference();
      update();
    });
  }

  createUser(
      {required String email, required String name, required String id}) async {
    final user = UserInformation(email: email, name: name, id: id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(user.toMap())
        .then((value) async {
      await SharePref.setData(key: 'user', data: id).then((value) async {
        if (value) {
          await getUserData();
          userId = await SharePref.getData(key: 'user');

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
                email: emailController.text,
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
    age = userInformation!.age;

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
      fetchFood();
    }
  }

  getUserData() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        if (value.data() != null) {
          userInformation = UserInformation.fromMap(value.data()!);
          gender = userInformation!.gender;
        }
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

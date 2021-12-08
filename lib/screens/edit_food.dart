import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/models/food_model.dart';
import 'package:mobile_computing_homework/utils/component.dart';
import 'package:mobile_computing_homework/utils/component.dart';

import '../controller/controller.dart';

class EditFood extends StatefulWidget {
  FoodModel model;

  EditFood(this.model);

  @override
  State<EditFood> createState() => _AddRecordState();
}

class _AddRecordState extends State<EditFood> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final control = Get.find<ControllerApp>();
    control.nameFoodController.text = widget.model.name;
    control.caloryFoodController.text = widget.model.calory.toString();
    control.categoryFoodController.text = widget.model.category;
    control.imagePicked = null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI Analyzer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GetBuilder<ControllerApp>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      'Edit Food Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: logic.nameFoodController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: logic.categoryFoodController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      'Calory',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Container(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: logic.caloryFoodController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Text('cal/g')
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    'photo',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 70),
                  width: 250,
                  height: 200,
                  child: (logic.imagePicked != null)
                      ? Image.file(
                          File(
                            logic.imagePicked!.path,
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(
                          Utility.dataFromBase64String(widget.model.photo)),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              logic.imgFromGallery();
                            },
                            child: Text('Select Photo'))),
                    SizedBox(
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (logic
                                      .categoryFoodController.text.isNotEmpty &&
                                  logic.caloryFoodController.text.isNotEmpty &&
                                  logic.nameFoodController.text.isNotEmpty) {
                                logic.updateFood(
                                    FoodModel(
                                        name: logic.nameFoodController.text,
                                        category:
                                            logic.categoryFoodController.text,
                                        photo: logic.imagePicked == null
                                            ? widget.model.photo
                                            : Utility.base64String(await logic
                                                .imagePicked!
                                                .readAsBytes()),
                                        calory: double.parse(
                                            logic.caloryFoodController.text)),
                                    widget.model.id!);
                              } else {
                                Get.snackbar('Complete Information',
                                    'Please Add All Information');
                              }
                            },
                            child: Text('Save '))),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

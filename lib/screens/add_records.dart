import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/screens/home_screen.dart';

import '../controller/controller.dart';
import 'info_screen.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
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
              children: [
                SizedBox(
                  height: size.height * .06,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      'New Record',
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
                  height: size.height * .08,
                ),
                Row(
                  children: [
                    Text(
                      'Weight',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.minimize,
                                  color: Colors.blue, size: 20),
                              onPressed: () {
                                if (!(int.parse(logic.weightController.text) <=
                                        10) &&
                                    (!(int.parse(logic.weightController.text) >=
                                        220)))
                                  logic.weightController.text =
                                      '${int.parse(logic.weightController.text) - 1}';
                              },
                              padding: EdgeInsets.zero,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: logic.weightController,
                                cursorHeight: 15,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            child: IconButton(
                              icon:
                                  Icon(Icons.add, color: Colors.blue, size: 20),
                              onPressed: () {
                                if (!(int.parse(logic.weightController.text) >=
                                    220))
                                  logic.weightController.text =
                                      '${int.parse(logic.weightController.text) + 1}';
                              },
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('  Kg')
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      'Length',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.minimize,
                                  color: Colors.blue, size: 20),
                              onPressed: () {
                                if (!(int.parse(logic.heightController.text) <=
                                        100) &&
                                    (!(int.parse(logic.heightController.text) >=
                                        220)))
                                  logic.heightController.text =
                                      '${int.parse(logic.heightController.text) - 1}';
                              },
                              padding: EdgeInsets.zero,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: logic.heightController,
                                cursorHeight: 15,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            child: IconButton(
                              icon:
                                  Icon(Icons.add, color: Colors.blue, size: 20),
                              onPressed: () {
                                if (!(int.parse(logic.heightController.text) >=
                                    220))
                                  logic.heightController.text =
                                      '${int.parse(logic.heightController.text) + 1}';
                              },
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('  cm')
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        onTap: () {
                          selectDate(context);
                        },
                        keyboardType: TextInputType.datetime,
                        textAlign: TextAlign.center,
                        controller: logic.dateController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: size.height * .1,
                ),
                SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (logic.dateController.text.isNotEmpty) {
                            logic.findBmi();
                            Get.back();
                          } else {
                            Get.snackbar('Complete Information',
                                'Please Select Date Of Birth ',
                                backgroundColor: Colors.blue);
                          }
                        },
                        child: Text('Save Data')))
              ],
            ),
          );
        }),
      ),
    );
  }
}

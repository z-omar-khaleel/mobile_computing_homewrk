import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mobile_computing_homework/login.dart';

import 'controller.dart';

class HomeScreen extends StatelessWidget {
  var x = Get.put(ControllerApp());
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI Analyzer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GetBuilder<ControllerApp>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Center(
                  child: Text(
                    'Hi ${logic.fromRegister ? logic.userNameController.text : logic.userController.text}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Text('Current State'),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    'Normal (Still Good)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.7),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Text('Old Status'),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .35,
                  color: Colors.blue.shade600,
                  child: ListView.builder(
                    itemBuilder: (c, i) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(120.0),
                        border: TableBorder.all(
                            color: Colors.lightBlue,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Text('20/10/2021',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black87))
                            ]),
                            Column(children: [
                              Text('60 kg',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black87))
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Text('Normal',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black87))
                            ]),
                            Column(children: [
                              Text('170 cm',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black87))
                            ]),
                          ]),
                        ],
                      ),
                    ),
                    itemCount: 20,
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: size.width * .42,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Add Food'))),
                    SizedBox(
                        width: size.width * .42,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Add Record'))),
                  ],
                ),
                SizedBox(
                  height: size.height * .015,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('View Food'))),
                SizedBox(
                  height: size.height * .01,
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          logic.closeAllController();
                          Get.offAll(LoginScreen());
                        },
                        child: Text('logout')))
              ],
            ),
          );
        }),
      ),
    );
  }
}

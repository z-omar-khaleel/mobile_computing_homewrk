import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
                  height: size.height * .1,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      'Complete Your Information',
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
                      'Gender',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Radio<String>(
                              value: 'Male',
                              groupValue: logic.gender,
                              onChanged: (value) {
                                logic.changeGender(value!);
                              },
                            ),
                            const Text(
                              'Male',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Radio<String>(
                              value: 'Female',
                              groupValue: logic.gender,
                              onChanged: (value) {
                                logic.changeGender(value!);
                              },
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
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
                    'Date Of Birth',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 27,
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
                          _selectDate(context);
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
                        onPressed: () {}, child: Text('Save Data')))
              ],
            ),
          );
        }),
      ),
    );
  }
}

_selectDate(BuildContext context) async {
  var contrller = Get.find<ControllerApp>();
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: contrller.selectedDate.value,
    firstDate: DateTime(1920),
    lastDate: DateTime.now(),
  );
  if (selected != null && selected != contrller.selectedDate.value)
    contrller.changeSelectedDate(selected);
  print(selected);
}

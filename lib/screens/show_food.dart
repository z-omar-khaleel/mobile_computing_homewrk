import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mobile_computing_homework/controller/controller.dart';
import 'package:mobile_computing_homework/models/food_model.dart';
import 'package:mobile_computing_homework/screens/edit_food.dart';
import 'package:mobile_computing_homework/utils/component.dart';

class ShowFood extends StatelessWidget {
  const ShowFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI Analyzer'),
      ),
      body: GetBuilder<ControllerApp>(builder: (logic) {
        print(logic.foods.length);
        return Padding(
          padding: EdgeInsets.all(16),
          child: ListView.separated(
              itemBuilder: (context, i) => buildFood(logic.foods[i], logic),
              separatorBuilder: (c, i) => SizedBox(
                    height: 15,
                  ),
              itemCount: logic.foods.length),
        );
      }),
    );
  }
}

Widget buildFood(FoodModel food, ControllerApp logic) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.blue))),
          child: Image.memory(
            Utility.dataFromBase64String(food.photo),
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 30,
                      width: 58,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(EditFood(food));
                        },
                        child: Text('Edit'),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                food.category,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        logic.deleteFood(food);
                      },
                      child: Text(
                        'X',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

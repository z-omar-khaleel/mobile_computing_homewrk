import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/controller.dart';
import 'package:mobile_computing_homework/sign_up.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI Analyzer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('If you already have account login',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .09,
              ),
              GetBuilder<ControllerApp>(builder: (ref) {
                return Form(
                    key: ref.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: 'UserName'),
                          controller: ref.userController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter Your User Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  ref.changVisability();
                                },
                                child: Icon(ref.isPass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                              )),
                          controller: ref.passController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter Your Password';
                            }
                            return null;
                          },
                          obscureText: ref.isPass,
                        ),
                        SizedBox(
                          height: size.height * .08,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                ref.validateLogin();
                              },
                              child: Text('log in'.toUpperCase())),
                        )
                      ],
                    ));
              }),
              SizedBox(
                height: size.height * .03,
              ),
              Wrap(
                children: [
                  Text('You Don\'t Have An Account '),
                  InkWell(
                    onTap: () {
                      Get.to(SignUp());
                    },
                    child: Text('Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

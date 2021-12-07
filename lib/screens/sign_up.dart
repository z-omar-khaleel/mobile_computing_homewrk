import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_computing_homework/controller/controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

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
          reverse: true,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Create New Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('If you do not already have account ',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              GetBuilder<ControllerApp>(builder: (ref) {
                return Form(
                    key: ref.formKeyRegister,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Name'),
                          controller: ref.userNameController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter Your Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                          controller: ref.emailController,
                          validator: (val) {
                            if (val == null ||
                                val.trim().isEmpty ||
                                !GetUtils.isEmail(val)) {
                              return 'Please enter Correct Email';
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
                          controller: ref.passRegisterController,
                          obscureText: ref.isPass,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter Your Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Re-Password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  ref.changVisability();
                                },
                                child: Icon(ref.isPass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                              )),
                          controller: ref.rePassController,
                          obscureText: ref.isPass,
                          validator: (val) {
                            if (val == null ||
                                val.trim().isEmpty ||
                                (ref.passRegisterController.text !=
                                    ref.rePassController.text)) {
                              return 'Please enter Correct Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .08,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                ref.validateRegister();
                              },
                              child: Text('Create'.toUpperCase())),
                        )
                      ],
                    ));
              }),
              SizedBox(
                height: size.height * .03,
              ),
              Wrap(
                children: [
                  Text('You  Have An Account ',
                      style: TextStyle(
                        color: Colors.black87,
                      )),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text('Login'),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationController controller = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Obx(() {
              return Form(
                key: _formKey,
                child: OverflowBar(
                  overflowSpacing: 20,
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Email is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                    TextFormField(
                      controller: controller.password,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Password is empty';
                        }
                        return null;
                      },
                      obscureText: controller.isObsecure.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: GestureDetector(
                          onTap:
                              controller.toggleObsecure, // Remove the () here
                          child: Icon(controller.isObsecure.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('validation done');
                            controller.signInWithEmailandPassword();
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/signup-screen');
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          controller.signInWithGoogle();
                        },
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset('assets/google.png'),
                              ),
                            ),
                            Text(
                              'Login With Google',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

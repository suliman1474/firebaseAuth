import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/controllers/auth_controller.dart';
import 'package:flutter_auth/views/login_screen.dart';
import 'package:flutter_auth/widgets/indicator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationController controller = Get.find<AuthenticationController>();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            controller.logout();
          },
          icon: Icon(Icons.logout),
          color: Colors.black,
        )
      ]),
      body: Center(
        child: Text('${user!.email}'),
      ),
    ));
  }
}

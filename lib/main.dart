import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/bindings/binding.dart';
import 'package:flutter_auth/routes.dart';
import 'package:flutter_auth/views/authView.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, c) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Auth",
          initialRoute: '/',
          initialBinding: Binding(),
          getPages: Routes(),
        );
      },
    ),
  );
}

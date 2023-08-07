import 'package:flutter_auth/views/authView.dart';
import 'package:flutter_auth/views/home_screen.dart';
import 'package:flutter_auth/views/login_screen.dart';
import 'package:flutter_auth/views/signup_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

Routes() => [
      GetPage(
        name: '/',
        page: () =>
            AuthView(), //HomeScreen(), //ConnectStripeScreen(), //StripePaymentScreen(), //
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 600),
      ),
      GetPage(
        name: '/home',
        page: () =>
            HomeScreen(), //HomeScreen(), //ConnectStripeScreen(), //StripePaymentScreen(), //
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 600),
      ),
      GetPage(
        name: '/login-screen',
        page: () =>
            LoginScreen(), //HomeScreen(), //ConnectStripeScreen(), //StripePaymentScreen(), //
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 600),
      ),
      GetPage(
        name: '/signup-screen',
        page: () =>
            SignupScreen(), //HomeScreen(), //ConnectStripeScreen(), //StripePaymentScreen(), //
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 600),
      ),
    ];

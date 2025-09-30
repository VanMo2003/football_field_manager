import 'package:flutter/material.dart';
import '../../controller/authentication_controller.dart';
import '../../screens/home_screen.dart';
import '../../screens/sign_in/sign_in_screen.dart';
import 'package:get/get.dart';

import 'unknown_screen.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (controller) {
        switch (controller.status) {
          case AuthenticationStatus.authentication:
            return HomeScreen();
          case AuthenticationStatus.un_authentication:
            return SignInScreen();
          default:
            return UnknownScreen();
        }
      },
    );
  }
}

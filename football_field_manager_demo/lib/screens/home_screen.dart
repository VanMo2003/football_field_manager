import 'package:flutter/material.dart';
import '../../screens/admin/admin_screen.dart';
import '../../screens/pitch_owner/pitch_owner_page.dart';
import 'user/user_screen.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        switch (controller.roles) {
          case Roles.admin:
            return AdminScreen();
          case Roles.manege:
            return ManegeScreen();
          case Roles.user:
            return UserScreen();
          default:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

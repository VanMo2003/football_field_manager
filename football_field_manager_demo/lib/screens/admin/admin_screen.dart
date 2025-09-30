import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/authentication_controller.dart';
import '../widgets/loading_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<AuthenticationController>().logout();
            },
            icon: Icon(Icons.logout),
          ),
        ),
        body: Center(
          child: Text("Admin"),
        ),
      ),
    );
  }
}

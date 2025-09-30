import 'package:flutter/material.dart';
import '../../controller/authentication_controller.dart';
import '../../controller/loading_controller.dart';
import '../../helper/route_helper.dart';
import '../../screens/widgets/loading_widget.dart';
import 'package:get/get.dart';
import '../../screens/widgets/button_text_widget.dart';
import '../../../utils/style.dart';

import '../../data/models/request/user_request.dart';
import '../../utils/dimension_utils.dart';

class PickRoleScreen extends StatelessWidget {
  const PickRoleScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DimensionUtils.PADDING_SIZE_DEFAULT,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chức năng của bạn?",
                  style: StyleUtils.button,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: Get.height * 0.15,
                      width: Get.height * 0.15,
                      child: ButtonTextWidget(label: "Chủ\nsân", onTap: () {}),
                    ),
                    Container(
                      height: Get.height * 0.15,
                      width: Get.height * 0.15,
                      child: ButtonTextWidget(
                        label: "Người\ndùng",
                        onTap: () {
                          Get.find<LoadingController>().loading(
                            handle: () async {
                              await Get.find<AuthenticationController>()
                                  .login(user.username!, user.password!)
                                  .then((value) {
                                    if (value == 200) {
                                      Get.toNamed(RouteHelper.home);
                                    }
                                  });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

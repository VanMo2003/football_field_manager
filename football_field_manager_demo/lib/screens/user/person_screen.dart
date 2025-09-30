import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/controller/user_controller.dart';
import 'package:football_field_manager_demo/screens/user/info_user_screen.dart';
import 'package:football_field_manager_demo/utils/dimension_utils.dart';
import 'package:football_field_manager_demo/utils/style.dart';
import 'package:get/get.dart';

import '../../controller/authentication_controller.dart';
import '../../utils/color_constant.dart';
import '../../utils/language/key_language.dart';
import '../widgets/button_icon_widget.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.amber,
            height: Get.height * 0.2,
            width: Get.width,
            child: Column(
              children: [
                CircleAvatar(
                  radius: DimensionUtils.BORDER_RADIUS_EXTRA_OVER_LARGE,
                  child: Icon(Icons.person, size: DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_OVER_LARGE,),
                ),
                GetBuilder<UserController>(
                  builder: (controller) {
                    return Text(controller.user?.fullName ?? "",
                    style: StyleUtils.styleTitleDefault,
                    );
                  }
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: DimensionUtils.PADDING_SIZE_DEFAULT),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(InfoUserScreen());
                    },
                    child: Container(
                      height: 50,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        color: ColorConstant.getWhiteColor(),
                        borderRadius: BorderRadius.circular(DimensionUtils.BORDER_RADIUS_DEFAULT),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.getBlackColor().withValues(alpha: 0.25),
                            offset: const Offset(0, 2),
                            spreadRadius: 2,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Center(child: Text("Thông tin cá nhân", style: StyleUtils.styleDefault,),),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

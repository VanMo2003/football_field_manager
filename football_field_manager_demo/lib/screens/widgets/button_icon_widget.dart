import 'package:flutter/material.dart';
import '../../../utils/color_constant.dart';
import 'package:get/get.dart';

import '../../utils/dimension_utils.dart';
import '../../../utils/style.dart';

class ButtonTextWidget extends StatelessWidget {
  const ButtonTextWidget({super.key, required this.label, required this.onTap});

  final void Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: Get.height * 0.06,
        padding: EdgeInsets.symmetric(
          horizontal: DimensionUtils.PADDING_SIZE_DEFAULT,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.getPrimaryColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: StyleUtils.button.copyWith(
              color: ColorConstant.getTextButtonPrimaryColor(),
            ),
          ),
        ),
      ),
    );
  }
}

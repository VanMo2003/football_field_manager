import 'package:flutter/material.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/style.dart';
import '../../controller/langue_controller.dart';
import 'package:get/get.dart';

import '../../services/language_service.dart';
import '../../utils/dimension_utils.dart';

class DropdownLanguageWidget extends StatefulWidget {
  const DropdownLanguageWidget({super.key});

  @override
  State<DropdownLanguageWidget> createState() => _DropdownLanguageWidgetState();
}

class _DropdownLanguageWidgetState extends State<DropdownLanguageWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = Get.find<LanguageController>().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 70,
      decoration: BoxDecoration(
        color: ColorConstant.getPrimaryColor(),
        borderRadius: BorderRadius.circular(
          DimensionUtils.BORDER_RADIUS_DEFAULT,
        ),
      ),
      child: Center(
        child: DropdownButton(
          value: selectedValue,
          borderRadius: BorderRadius.circular(
            DimensionUtils.BORDER_RADIUS_DEFAULT,
          ),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
              Get.find<LanguageController>().changeLocale(
                selectedValue ?? "vi",
              );
            });
          },
          alignment: Alignment.center,
          items: LanguageService.langCodes.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: StyleUtils.styleDefault.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
              ),
            );
          }).toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).canvasColor,
          ),
          underline: const SizedBox(),
        ),
      ),
    );
  }
}

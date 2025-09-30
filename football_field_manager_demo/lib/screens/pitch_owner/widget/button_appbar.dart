import 'package:flutter/material.dart';
import '../../../utils/style.dart';
import 'package:get/get.dart';

import '../../../utils/dimension_utils.dart';

class ButtonAppbar extends StatelessWidget {
  const ButtonAppbar({
    super.key,
    required this.onTap,
    required this.icons,
    required this.label,
  });

  final void Function() onTap;
  final IconData icons;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: Get.height * 0.06,
        width: Get.width / 2 - 20,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.black38,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
            Icon(icons, color: Theme.of(context).primaryColorLight),
            const SizedBox(width: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
            StyleUtils.defaultTextStyle(text: label),
          ],
        ),
      ),
    );
  }
}

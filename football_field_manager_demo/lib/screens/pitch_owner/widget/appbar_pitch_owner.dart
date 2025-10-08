import 'package:flutter/material.dart';
import '../../../controller/calendar_controller.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/color_constant.dart';
import 'package:get/get.dart';
import '../../../utils/date_convert.dart';
import '../../../utils/dimension_utils.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';
import '../../calendar/calendar_screen.dart';
import 'button_appbar.dart';

class AppbarPitchOwner extends StatelessWidget {
  const AppbarPitchOwner({
    super.key,
    this.footballFieldName,
    this.defaultImageUrl = "",
  });

  final String? footballFieldName;
  final String? defaultImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DimensionUtils.BORDER_RADIUS_OVER_LARGE),
        ),
        image: DecorationImage(
          opacity: 0.6,
          image: NetworkImage(
            "${AppConstant.ENDPOINT_GET_IMAGE}/$defaultImageUrl",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: DimensionUtils.ICON_SIZE_DEFAULT,
                  ),
                ),
                StyleUtils.defaultTextStyle(
                  text: footballFieldName ?? KeyLanguage.nameFootballFile.tr,
                  style: StyleUtils.titleLarge.copyWith(
                    fontSize: DimensionUtils.FONT_SIZE_OVER_OVER_LARGE,
                    color: ColorConstant.getTextPrimaryColor(),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: DimensionUtils.ICON_SIZE_DEFAULT,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GetBuilder<CalendarController>(
                  builder: (controller) {
                    return ButtonAppbar(
                      icons: Icons.calendar_month,
                      label: DateConvert.dateTimeToString(
                        controller.selectedDate,
                      ),
                      onTap: () {
                        Get.to(CalendarScreen());
                      },
                    );
                  },
                ),
                ButtonAppbar(
                  icons: Icons.notifications_active_rounded,
                  label: KeyLanguage.notification.tr,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
          ],
        ),
      ),
    );
  }
}

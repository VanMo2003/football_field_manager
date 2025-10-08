import 'package:flutter/material.dart';
import '../../../controller/calendar_controller.dart';
import '../../../utils/color_constant.dart';
import 'package:get/get.dart';
import '../../../utils/date_convert.dart';
import '../../../utils/dimension_utils.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';
import '../../calendar/calendar_screen.dart';
import 'button_appbar.dart';

class AppbarPitchOwner extends StatelessWidget {
  AppbarPitchOwner({super.key, this.footballFieldName});

  final String? footballFieldName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.23,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DimensionUtils.BORDER_RADIUS_OVER_LARGE),
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
                  icon: Icon(
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
                  icon: Icon(
                    Icons.settings,
                    size: DimensionUtils.ICON_SIZE_DEFAULT,
                  ),
                ),
              ],
            ),
            Spacer(),
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

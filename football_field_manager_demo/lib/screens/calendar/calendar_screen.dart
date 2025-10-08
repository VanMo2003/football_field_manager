import 'package:flutter/material.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';
import 'package:get/get.dart';
import '../../utils/date_convert.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/calendar_controller.dart';
import '../../utils/dimension_utils.dart';
import '../widgets/button_text_widget.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Rx<DateTime> selected = DateTime.now().obs;

  @override
  void initState() {
    super.initState();
    selected.value = Get.find<CalendarController>().selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.house,
            color: ColorConstant.getTextPrimaryColor(),
            size: DimensionUtils.ICON_SIZE_DEFAULT,
          ),
        ),
        title: Text(
          KeyLanguage.selectedDate.tr,
          style: StyleUtils.styleTitleDefault.copyWith(
            color: ColorConstant.getTextPrimaryColor(),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.getBackgroundAppBar(),
      ),
      body: Obx(() {
        return Column(
          children: [
            Text(
              DateConvert.dateTimeToString(selected.value),
              style: TextStyle(
                fontSize: 24,
                color: ColorConstant.getPrimaryColor(),
              ),
            ),
            TableCalendar(
              rowHeight: 43,
              focusedDay: selected.value,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: StyleUtils.styleDefault.copyWith(
                  color: ColorConstant.getTextPrimaryColor(),
                ),
              ),
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(
                  color: ColorConstant.getWeekendDay(),
                ),
                outsideDaysVisible: false,
                defaultTextStyle: TextStyle(
                  color: Theme.of(context).canvasColor,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: ColorConstant.getTextPrimaryColor(),
                ),
                weekendStyle: TextStyle(color: ColorConstant.getWeekendDay()),
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_OVER_LARGE,
              locale: 'en_US',
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, selected.value),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: (selectedDay, focusedDay) {
                selected.value = selectedDay;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DimensionUtils.PADDING_SIZE_DEFAULT,
                horizontal: DimensionUtils.BORDER_RADIUS_EXTRA_OVER_LARGE,
              ),
              child: ButtonTextWidget(
                label: KeyLanguage.agree.tr,
                onTap: () {
                  Get.find<CalendarController>().changePickCalendar(
                    selected.value,
                  );
                  Get.back();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

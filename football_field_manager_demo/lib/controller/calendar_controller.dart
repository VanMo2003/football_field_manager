import 'package:football_field_manager_demo/controller/booking_controller.dart';
import 'package:football_field_manager_demo/controller/football_field_controller.dart';
import 'package:football_field_manager_demo/utils/date_convert.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController implements GetxService {
  CalendarController();

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void changePickCalendar(DateTime dateTime) {
    _selectedDate = dateTime;

    Get.find<BookingController>().clearData();

    Get.find<BookingController>().getAllByFootballFieldAndBookingDate(
      Get.find<FootballFieldController>().footballPitch?.id ?? 0,
        DateConvert.stringFormatToRequest(DateConvert.dateTimeToString(_selectedDate))
    );

    update();
  }

  void clearData() {
    _selectedDate = DateTime.now();
  }
}

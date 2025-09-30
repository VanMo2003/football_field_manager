import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/controller/booking_controller.dart';
import 'package:football_field_manager_demo/controller/calendar_controller.dart';
import 'package:football_field_manager_demo/controller/football_field_controller.dart';
import 'package:football_field_manager_demo/utils/date_convert.dart';
import 'package:get/get.dart';
import 'package:football_field_manager_demo/data/models/response/football_pitch_response.dart';
import 'package:football_field_manager_demo/screens/pitch_owner/widget/body_pitch_owner.dart';

import '../../../controller/time_slot_controller.dart';
import '../../pitch_owner/widget/appbar_pitch_owner.dart';

class DetailFootballField extends StatefulWidget {
  const DetailFootballField({super.key, required this.footballFieldResponse});

  final FootballFieldResponse footballFieldResponse;

  @override
  State<DetailFootballField> createState() => _DetailFootballFieldState();
}

class _DetailFootballFieldState extends State<DetailFootballField> {
  @override
  void initState() {
    super.initState();
    Get.find<FootballFieldController>().setFootballField(widget.footballFieldResponse);
    String bookingDate = DateConvert.stringFormatToRequest(DateConvert.dateTimeToString(Get.find<CalendarController>().selectedDate));
    Get.find<BookingController>().getAllByFootballFieldAndBookingDate(
        widget.footballFieldResponse.id ?? 0,
        bookingDate
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<FootballFieldController>().clearFootballField();
    Get.find<TimeSlotController>().clearData();
    Get.find<BookingController>().clearData();
    Get.find<CalendarController>().clearData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppbarPitchOwner(footballFieldName: widget.footballFieldResponse.name),
          BodyFootballField(
            footballFieldResponse: widget.footballFieldResponse,
          ),
        ],
      ),
    );
  }
}

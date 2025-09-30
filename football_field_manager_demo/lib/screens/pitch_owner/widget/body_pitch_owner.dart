import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/controller/booking_controller.dart';
import 'package:football_field_manager_demo/controller/calendar_controller.dart';
import 'package:football_field_manager_demo/controller/time_slot_controller.dart';
import 'package:football_field_manager_demo/data/models/request/booking_request.dart';
import 'package:football_field_manager_demo/data/models/response/booking_response.dart';
import 'package:football_field_manager_demo/data/models/response/football_pitch_response.dart';
import 'package:football_field_manager_demo/utils/date_convert.dart';
import '../../../controller/side_bar_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../helper/line_paint.dart';
import '../../../utils/style.dart';

import '../../../utils/language/key_language.dart';
import 'package:get/get.dart';

import '../../../data/models/response/time_slot_response.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimension_utils.dart';
import '../../user/widgets/booking_dialog.dart';
import 'body_pitch_owner_item.dart';

class BodyFootballField extends StatefulWidget {
  const BodyFootballField({super.key, this.footballFieldResponse});

  final FootballFieldResponse? footballFieldResponse;

  @override
  State<BodyFootballField> createState() => _BodyFootballFieldState();
}

class _BodyFootballFieldState extends State<BodyFootballField> {
  final ScrollController controllerNumberYard = ScrollController();
  final ScrollController controllerTimeSlot = ScrollController();
  final ScrollController controllerVer = ScrollController();
  final ScrollController controllerHor = ScrollController();

  List<int> indexFootballFieldPlaced = [];

  @override
  void initState() {
    super.initState();

    Get.find<TimeSlotController>().getAllTimeSlotByFootballField(widget.footballFieldResponse?.id ?? 0);

    controllerVer.addListener(() {
      if (controllerVer.offset != controllerTimeSlot.offset) {
        controllerTimeSlot.jumpTo(controllerVer.offset);
      }
    });

    controllerTimeSlot.addListener(() {
      if (controllerVer.offset != controllerTimeSlot.offset) {
        controllerVer.jumpTo(controllerTimeSlot.offset);
      }
    });

    controllerHor.addListener(() {
      if (controllerHor.offset != controllerNumberYard.offset) {
        controllerNumberYard.jumpTo(controllerHor.offset);
      }
    });
    controllerNumberYard.addListener(() {
      if (controllerHor.offset != controllerNumberYard.offset) {
        controllerHor.jumpTo(controllerNumberYard.offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: Get.width,
        height: Get.height * 0.77,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GetBuilder<TimeSlotController>(
          builder: (timeSlotController) {
            if (timeSlotController.timeSlotResponse == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (timeSlotController.timeSlotResponse!.isEmpty) {
              return const Center(
                child: Text(
                  "Sân hiện chưa có thông tin về khung giờ",
                  style: TextStyle(fontSize: DimensionUtils.FONT_SIZE_LARGE),
                ),
              );
            }

            int numberYard = widget.footballFieldResponse?.totalPitches ?? 0;
            int numberTimeSlot = timeSlotController.timeSlotResponse!.length;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: ColorConstant.getBackgroundGrey(),
                    height: Get.height * 0.77 * 1 / 8 * (numberTimeSlot + 1),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(width: 1, color: ColorConstant.getBorder())),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: CustomPaint(foregroundPainter: LinePaint()),
                                ),
                                Positioned(
                                  right: 0,
                                  child: StyleUtils.defaultTextStyle(
                                    text: KeyLanguage.yard.tr,
                                    style: TextStyle(
                                      fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: StyleUtils.defaultTextStyle(
                                    text: "Giờ",
                                    style: TextStyle(
                                      fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: numberTimeSlot,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(border: Border.all(width: 1, color: ColorConstant.getBorder())),
                            child: widgetTimeSlot(timeSlotController.timeSlotResponse!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          controller: controllerNumberYard,
                          physics: const BouncingScrollPhysics(),
                          itemCount: numberYard,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width:
                                  Get.width *
                                  7 /
                                  9 /
                                  (numberYard < DimensionUtils.MAX_YARD ? numberYard : DimensionUtils.MAX_YARD),
                              decoration: BoxDecoration(
                                color: ColorConstant.getBackgroundGrey(),
                                border: Border.all(width: 1, color: ColorConstant.getBorder()),
                              ),
                              child: Center(
                                child: StyleUtils.defaultTextStyle(
                                  text: "${index + 1}",
                                  style: TextStyle(
                                    fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          controller: controllerVer,
                          child: Container(
                            width: Get.width * 7 / 9 * numberYard,
                            height: Get.height * 0.77 * 1 / 8 * (numberTimeSlot),
                            child: GetBuilder<BookingController>(
                              builder: (controller) {
                                indexFootballFieldPlaced.clear();
                                List<BookingResponse>? bookingResponses = controller.bookingResponse;
                                if (bookingResponses != null) {
                                  if (bookingResponses.isNotEmpty) {
                                    for (var booking in bookingResponses) {
                                      int indexTimeslot = Get.find<TimeSlotController>().timeSlotResponse!.indexWhere(
                                        (timeslot) => timeslot.id == booking.timeSlot!.id,
                                      );
                                      indexFootballFieldPlaced.add(
                                        numberTimeSlot * (booking.pitchNumber! - 1) + indexTimeslot,
                                      );
                                    }
                                  }
                                }
                                log(indexFootballFieldPlaced.toList().toString());
                                return GridView.builder(
                                  controller: controllerHor,
                                  scrollDirection: Axis.horizontal,
                                  physics: Get.find<SideBarController>().isOpenSideBar
                                      ? const NeverScrollableScrollPhysics()
                                      : null,
                                  itemCount: numberYard * numberTimeSlot,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: numberTimeSlot,
                                    childAspectRatio: 1 / 2,
                                    mainAxisExtent:
                                        Get.width *
                                        7 /
                                        9 /
                                        (numberYard < DimensionUtils.MAX_YARD ? numberYard : DimensionUtils.MAX_YARD),
                                  ),
                                  itemBuilder: (context, index) {
                                    return BodyPitchOwnerItem(
                                      isPlaced: indexFootballFieldPlaced.contains(index),
                                      callback: () {
                                        int lengthTimeSlot = timeSlotController.timeSlotResponse!.length;
                                        TimeSlotResponse timeSlot = Get.find<TimeSlotController>().timeSlotResponse!
                                            .elementAt(index % lengthTimeSlot);
                                        int numberFootballField = (index / lengthTimeSlot).toInt() + 1;
                                        showDialog(
                                          context: context,
                                          builder: (context) => BookingDialog(
                                            tenSan: widget.footballFieldResponse?.name ?? "",
                                            diaChi: widget.footballFieldResponse?.location ?? "",
                                            ngayDat: DateConvert.dateTimeToString(
                                              Get.find<CalendarController>().selectedDate,
                                            ),
                                            soDienThoai: Get.find<UserController>().user?.phoneNumber ?? "",
                                            khungGio: "${timeSlot.startTime} - ${timeSlot.endTime}",
                                            soSan: numberFootballField,
                                            tongGia: 300000,
                                            onConfirm: () {
                                              // Xử lý khi nhấn xác nhận
                                              BookingRequest booking = BookingRequest(
                                                footballFieldId: widget.footballFieldResponse?.id ?? 0,
                                                pitchNumber: numberFootballField,
                                                bookingDate: DateConvert.stringFormatToRequest(
                                                  DateConvert.dateTimeToString(
                                                    Get.find<CalendarController>().selectedDate,
                                                  ),
                                                ),
                                                serviceIds: [],
                                                timeSlotId: timeSlot.id,
                                                userPhoneNumber: Get.find<UserController>().user?.phoneNumber,
                                                price: timeSlot.price?.toInt(),
                                              );

                                              Get.find<BookingController>().createBooking(booking);

                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget widgetTimeSlot(List<TimeSlotResponse> timeSlots) {
    List<Widget> list = [];
    // sort(timeSlots);
    for (var element in timeSlots) {
      String startTime = element.startTime.toString();
      String endTime = element.endTime.toString();

      list.add(
        new Container(
          width: Get.width * 2 / 9,
          height: Get.height * 0.77 * 7 / 8 / 7,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: ColorConstant.getBorder())),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(top: 0, child: textTime(startTime)),
              Positioned(bottom: 0, child: textTime(endTime, isBegin: false)),
            ],
          ),
        ),
      );
    }
    return Container(
      width: Get.width * 2 / 7,
      height: Get.height * 0.77 * 7 / 8,
      child: SingleChildScrollView(
        controller: controllerTimeSlot,
        physics: Get.find<SideBarController>().isOpenSideBar ? NeverScrollableScrollPhysics() : null,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list),
      ),
    );
  }

  Widget textTime(String time, {bool isBegin = true}) {
    return StyleUtils.defaultTextStyle(
      text: time,
      style: StyleUtils.styleDefault.copyWith(color: isBegin ? Colors.green : Colors.red),
    );
  }
}

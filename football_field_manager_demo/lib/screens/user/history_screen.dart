import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/controller/booking_controller.dart';
import 'package:football_field_manager_demo/data/models/response/booking_response.dart';
import 'package:football_field_manager_demo/utils/assets_utils.dart';
import 'package:football_field_manager_demo/utils/date_convert.dart';
import 'package:football_field_manager_demo/utils/dimension_utils.dart';
import 'package:football_field_manager_demo/utils/style.dart';
import 'package:get/get.dart';

import '../../utils/color_constant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    if (Get.find<BookingController>().bookingByUsers == null) {
      Get.find<BookingController>().getAllByUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (bookingController) {
        if (bookingController.bookingByUsers == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (bookingController.bookingByUsers!.isEmpty) {
          return Center(
            child: Text(
              "Danh sách trống",
              style: StyleUtils.styleDefault.copyWith(fontSize: DimensionUtils.FONT_SIZE_EXTRA_LARGE),
            ),
          );
        }

        List<BookingResponse>? booking = bookingController.bookingByUsers;

        return ListView.separated(
          itemCount: booking!.length,
          itemBuilder: (context, index) {
            BookingResponse bookingResponse = booking[index];
            return Container(
              margin: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: DimensionUtils.PADDING_SIZE_SMALL,
                horizontal: DimensionUtils.PADDING_SIZE_SMALL * 2,
              ),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(DimensionUtils.BORDER_RADIUS_DEFAULT)),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.getBlackColor().withValues(alpha: 0.25),
                    offset: const Offset(0, 2),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(AssetsUtils.getImagePitch(1)), fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(DimensionUtils.BORDER_RADIUS_EXTRA_SMALL)),
                    ),
                  ),
                  SizedBox(width: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookingResponse.footballField?.name ?? "",
                            maxLines: 2,
                            style: StyleUtils.titleLarge.copyWith(fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE),
                          ),
                          Text(
                            "Ngày đặt sân : ${bookingResponse.bookingDate == null ? DateConvert.dateTimeToString(DateTime.now()) : DateConvert.dateTimeToString(DateConvert.stringResponseToDateTime(bookingResponse.bookingDate!))}",
                            style: StyleUtils.styleDefault,
                          ),
                          Text(
                            "Số sân : ${bookingResponse.pitchNumber}",
                            style: StyleUtils.styleDefault.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "Khung giờ : ${bookingResponse.timeSlot?.startTime ?? ""} - ${bookingResponse.timeSlot?.endTime ?? ""} ",
                            style: StyleUtils.styleDefault.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
        );
      },
    );
  }
}

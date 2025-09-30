import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/helper/route_helper.dart';
import 'package:football_field_manager_demo/screens/user/widgets/football_field_detail.dart';
import 'package:football_field_manager_demo/screens/user/widgets/icon_text.dart';
import '../../../data/models/response/football_pitch_response.dart';
import 'package:get/get.dart';

import '../../../utils/assets_utils.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimension_utils.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';

class FootballFieldItem extends StatelessWidget {
  const FootballFieldItem({
    super.key,
    required this.footballFieldResponse,
    this.isLast = false,
    required this.index,
  });

  final FootballFieldResponse footballFieldResponse;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: DimensionUtils.PADDING_SIZE_SMALL,
        bottom: DimensionUtils.PADDING_SIZE_SMALL,
        right: isLast
            ? DimensionUtils.PADDING_SIZE_SMALL
            : DimensionUtils.PADDING_SIZE_DEFAULT,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.getWhiteColor(),
        borderRadius: BorderRadius.circular(
          DimensionUtils.BORDER_RADIUS_DEFAULT,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.getBlackColor().withValues(alpha: 0.25),
            offset: const Offset(0, 2),
            spreadRadius: 2,
            blurRadius: 7,
          ),
        ],
      ),
      width: Get.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.4 * 0.4,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(
                DimensionUtils.BORDER_RADIUS_DEFAULT,
              ),
              image: DecorationImage(
                image:  AssetImage(AssetsUtils.getImagePitch(1)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DimensionUtils.PADDING_SIZE_SMALL,
                horizontal: DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${footballFieldResponse.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleUtils.styleTitleDefault.copyWith(
                      fontSize: DimensionUtils.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconText(
                    pathIcon: AssetsUtils.iconAddress,
                    content: footballFieldResponse.location ?? "",
                    maxLines: 3,
                    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                  ),
                  const Spacer(),
                  const IconText(
                    pathIcon: AssetsUtils.iconClock,
                    content: "8:00 - 22h00",
                    color: Colors.green,
                  ),
                  const Spacer(),
                  IconText(
                    pathIcon: AssetsUtils.iconDollar,
                    content: "${footballFieldResponse.price} VND",
                    color: Colors.amber,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            log("click to pitch : ${footballFieldResponse.name}");

                            Get.to(DetailFootballField(footballFieldResponse: footballFieldResponse));
                          },
                          child: Container(
                            height: Get.height * 0.04,

                            padding: const EdgeInsets.symmetric(
                              horizontal: DimensionUtils.PADDING_SIZE_DEFAULT,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstant.getPrimaryColor(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                KeyLanguage.seeDetail.tr,
                                style: StyleUtils.styleDefault.copyWith(
                                  color:
                                      ColorConstant.getTextButtonPrimaryColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(AssetsUtils.iconFavorite, scale: 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget evaluate(double averageRating) {
    List<Widget> list = [];
    for (var i = 1; i <= 5; i++) {
      list.add(
        Icon(
          Icons.star,
          size: DimensionUtils.ICON_SIZE_SMALL,
          color: i < averageRating ? Colors.amber : Colors.white,
        ),
      );
    }

    return Row(children: list);
  }
}

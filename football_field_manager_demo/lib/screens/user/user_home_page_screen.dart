// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../controller/football_field_controller.dart'
    show FootballFieldController;
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../utils/dimension_utils.dart';
import '../../utils/language/key_language.dart' show KeyLanguage;
import '../../utils/style.dart';
import 'widgets/football_field_item.dart';

class UserHomePageScreen extends StatefulWidget {
  const UserHomePageScreen({super.key});

  @override
  State<UserHomePageScreen> createState() => _UserHomePageScreenState();
}

class _UserHomePageScreenState extends State<UserHomePageScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(Get.find<FootballFieldController>().footballFields == null){
      Get.find<FootballFieldController>().getAllFootballFields().then((value) {
        if (value == 200) {
          Future.delayed(Durations.extralong4, () {
            Get.find<FootballFieldController>().noLoading();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: top * 1.5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: DimensionUtils.PADDING_SIZE_SMALL,
                left: DimensionUtils.PADDING_SIZE_SMALL,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(KeyLanguage.soccerField.tr, style: StyleUtils.button),
                  Text(KeyLanguage.seeAll.tr, style: StyleUtils.buttonLink),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.4,
              child: GetBuilder<FootballFieldController>(
                builder: (footballPitchController) {
                  return Skeletonizer(
                    enabled: footballPitchController.loading,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: footballPitchController.footballFields != null
                          ? footballPitchController.footballFields!.length
                          : 0,
                      itemBuilder: (context, index) {
                        return FootballFieldItem(
                          index: index,
                          footballFieldResponse:
                              footballPitchController.footballFields![index],
                          isLast:
                              index ==
                              footballPitchController.footballFields!.length -
                                  1,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: DimensionUtils.PADDING_SIZE_SMALL,
                    ),
                    child: Text("Gần đây", style: StyleUtils.button),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.4,
              child: GetBuilder<FootballFieldController>(
                builder: (footballPitchController) {
                  return Skeletonizer(
                    enabled: footballPitchController.loading,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: footballPitchController.footballFields != null
                          ? footballPitchController.footballFields!.length
                          : 0,
                      itemBuilder: (context, index) {
                        return FootballFieldItem(
                          index: index,
                          footballFieldResponse:
                          footballPitchController.footballFields![index],
                          isLast:
                          index ==
                              footballPitchController.footballFields!.length -
                                  1,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

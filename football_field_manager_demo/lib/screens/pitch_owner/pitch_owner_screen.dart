import 'dart:math';

import 'package:flutter/material.dart';
import '../../../controller/side_bar_controller.dart';

import '../../screens/pitch_owner/widget/appbar_pitch_owner.dart';
import 'package:get/get.dart';

import 'widget/body_pitch_owner.dart';

class PitchOwnerScreen extends StatefulWidget {
  const PitchOwnerScreen({super.key});

  @override
  State<PitchOwnerScreen> createState() => _PitchOwnerScreenState();
}

class _PitchOwnerScreenState extends State<PitchOwnerScreen> {
  @override
  void dispose() {
    super.dispose();
    Get.find<SideBarController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideBarController>(
      builder: (sideBarController) {
        return AnimatedContainer(
          transform:
              Matrix4.translationValues(
                  sideBarController.xOffset,
                  sideBarController.yOffset,
                  0,
                )
                ..scale(sideBarController.isOpenSideBar ? 0.9 : 1.0)
                ..rotateZ(sideBarController.isOpenSideBar ? pi / 20 : 0),
          duration: Duration(milliseconds: 200),
          child: Column(children: [AppbarPitchOwner(), BodyFootballField()]),
        );
      },
    );
  }
}

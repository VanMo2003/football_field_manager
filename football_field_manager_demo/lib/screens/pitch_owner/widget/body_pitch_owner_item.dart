import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/utils/assets_utils.dart';
import 'package:football_field_manager_demo/utils/dimension_utils.dart';

import '../../../utils/color_constant.dart';

class BodyPitchOwnerItem extends StatefulWidget {
  BodyPitchOwnerItem({super.key, required this.isPlaced, required this.callback});

  final bool isPlaced;

  void Function() callback;

  @override
  State<BodyPitchOwnerItem> createState() => _BodyPitchOwnerItemState();
}

class _BodyPitchOwnerItemState extends State<BodyPitchOwnerItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isPlaced
          ? null
          : () {
              widget.callback();
            },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorConstant.getBorder()),
          color: Theme.of(context).cardColor,
        ),
        child: Center(
          child: widget.isPlaced
              ? Image.asset(AssetsUtils.iconFootball, color: Colors.green, scale: 0.7,)
              : Icon(Icons.add_box_outlined, color: ColorConstant.getGreyColor()),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utils/dimension_utils.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.pathIcon,
    required this.content,
    this.fontSize = DimensionUtils.FONT_SIZE_SMALL,
    this.maxLines = 1,
    this.color = Colors.black,
  });

  final String pathIcon;
  final String content;
  final double fontSize;
  final int maxLines;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
          child: Image.asset(
            pathIcon,
            height: DimensionUtils.ICON_SIZE_SMALL,
            width: DimensionUtils.ICON_SIZE_SMALL,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left:
                DimensionUtils.ICON_SIZE_SMALL +
                DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
          ),
          child: Text(
            content,
            style: TextStyle(
                fontSize: fontSize,
                color: color
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/style.dart';
import 'package:get/get.dart';
import '../../utils/dimension_utils.dart';
import '../../../utils/language/key_language.dart';

class DialogQuestionWidget extends StatelessWidget {
  const DialogQuestionWidget({
    super.key,
    required this.label,
    required this.question,
    required this.agree,
  });

  final String label;
  final String question;
  final void Function() agree;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      title: Text(
        label,
        style: StyleUtils.titleLarge.copyWith(
          fontSize: DimensionUtils.FONT_SIZE_EXTRA_OVER_LARGE,
          color: ColorConstant.getTextPrimaryColor(),
        ),
      ),
      content: Text(
        question,
        style: StyleUtils.styleDefault.copyWith(
          color: ColorConstant.getTextPrimaryColor(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          child: Text(KeyLanguage.cancel.tr),
        ),
        ElevatedButton(
          onPressed: () {
            // SystemChannels.platform.invokeMethod(
            //     'SystemNavigator.pop'); // thoát app
            agree();
            Navigator.of(context).pop(false);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          child: Text(KeyLanguage.agree.tr),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/views/custom_snackbar.dart';
import '../../controller/authentication_controller.dart';
import '../../controller/loading_controller.dart';
import '../../screens/widgets/button_text_widget.dart';
import '../../theme/theme_controller.dart';
import '../../../utils/color_constant.dart';
import 'package:get/get.dart';

import '../../helper/route_helper.dart';
import '../../helper/valid_helper.dart';
import '../../utils/dimension_utils.dart';
import '../../../utils/style.dart';
import '../widgets/text_field_widget.dart';
import '/utils/assets_utils.dart';
import '/utils/language/key_language.dart';
import '../widgets/loading_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensionUtils.PADDING_SIZE_SMALL,
              ),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: DimensionUtils.ICON_SIZE_LOGO,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AssetsUtils.logoFootball),
                          colorFilter: Get.find<ThemeController>().darkTheme
                              ? ColorFilter.linearToSrgbGamma()
                              : null,
                        ),
                      ),
                    ),
                    Text(
                      KeyLanguage.signIn.tr,
                      style: StyleUtils.titleLarge.copyWith(
                        color: Theme.of(Get.context!).canvasColor,
                      ),
                    ),
                    TextFieldWidget(
                      controller: usernameController,
                      labelText: KeyLanguage.username.tr,
                    ),
                    SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                    TextFieldWidget(
                      controller: passwordController,
                      labelText: KeyLanguage.password.tr,
                      isPasswordField: true,
                      validator: (value) {
                        return ValidationHelper.validPassword(value);
                      },
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE,
                    ),
                    ButtonTextWidget(
                      label: KeyLanguage.signIn.tr,
                      onTap: () {
                        signIn();
                      },
                    ),
                    const SizedBox(
                      height:
                          DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER *
                          2 /
                          3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          KeyLanguage.questionSignUp.tr,
                          style: TextStyle(
                            color: ColorConstant.getTextPrimaryColor(),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {
                            toSignUp();
                          },
                          child: Text(
                            KeyLanguage.signUp.tr,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    if (form.currentState!.validate()) {
      Get.find<LoadingController>().loading(
        handle: () async {
          await Get.find<AuthenticationController>().login(
            usernameController.text,
            passwordController.text,
          );
        },
      );
    }
  }

  void toSignUp() async {
    Get.find<LoadingController>().loading(
      handle: () async {
        await Get.offNamed(RouteHelper.signUp);
      },
    );
  }
}

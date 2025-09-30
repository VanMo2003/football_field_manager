import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../controller/user_controller.dart';
import '../../screens/sign_up/enter_info_screen.dart';
import '../../views/custom_snackbar.dart';
import 'package:get/get.dart';
import '../../controller/loading_controller.dart';
import '../../data/models/request/user_request.dart';
import '../../helper/route_helper.dart';
import '../../helper/valid_helper.dart';
import '../../../utils/color_constant.dart';
import '../../utils/dimension_utils.dart';
import '../../../utils/style.dart';
import '../widgets/button_text_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_field_widget.dart';
import '/utils/assets_utils.dart';
import '/utils/language/key_language.dart';

class SignUpScreent extends StatelessWidget {
  SignUpScreent({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cfPasswordController = TextEditingController();

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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AssetsUtils.logoFootball),
                        ),
                      ),
                    ),
                    Text(
                      KeyLanguage.signUp.tr,
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
                    SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                    TextFieldWidget(
                      controller: cfPasswordController,
                      labelText: KeyLanguage.comfirmPassword.tr,
                      isPasswordField: true,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE,
                    ),
                    ButtonTextWidget(
                      label: KeyLanguage.signUp.tr,
                      onTap: () {
                        signUp();
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
                          KeyLanguage.questionSignIn.tr,
                          style: TextStyle(
                            color: ColorConstant.getTextPrimaryColor(),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {
                            toSignIn();
                          },
                          child: Text(
                            KeyLanguage.signIn.tr,
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

  void signUp() {
    String username = usernameController.text;
    String password = passwordController.text;
    String cfPassword = cfPasswordController.text;
    if (form.currentState!.validate()) {
      log('đầy đủ thông tin');
      Get.find<LoadingController>().loading(
        handle: () async {
          if (password != cfPassword) {
            showCustomSnackBar(
              KeyLanguage.errorPasswordsDuplicate.tr,
              isError: true,
            );
          } else {
            await Get.find<UserController>().checkExistUser(username).then((
              value,
            ) {
              if (value) {
                showCustomSnackBar(
                  KeyLanguage.existedUsername.tr,
                  isError: true,
                );
              } else {
                // Get.find<UserController>().setUserRequest(username, password);
                Get.offAll(
                  () => EnterInfoScreen(
                    user: User(username: username, password: password),
                  ),
                );
              }
            });
          }
        },
      );
    }
  }

  void toSignIn() async {
    Get.find<LoadingController>().loading(
      handle: () async {
        await Get.offNamed(RouteHelper.signIn);
      },
    );
  }
}

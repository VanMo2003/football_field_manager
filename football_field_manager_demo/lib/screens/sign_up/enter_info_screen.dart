import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../controller/user_controller.dart';
import '../../data/models/request/user_request.dart';
import '../../screens/sign_up/pick_role_screen.dart';
import '../../utils/app_constant.dart';
import '../../utils/date_convert.dart';
import 'package:get/get.dart';
import '../../controller/loading_controller.dart';
import '../../helper/route_helper.dart';
import '../../helper/valid_helper.dart';
import '../../utils/dimension_utils.dart';
import '../../../utils/style.dart';
import 'widgets/custom_dialog_calendar.dart';
import '../widgets/button_text_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_field_widget.dart';
import '/utils/language/key_language.dart';
import 'widgets/birth_place_dropdown.dart';
import 'widgets/radio_gender.dart';

class EnterInfoScreen extends StatelessWidget {
  EnterInfoScreen({super.key, required this.user});

  final User user;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedBirthPlace = AppConstant.birthPlaces[0];
  RxString dob = DateConvert.dateTimeToString(DateTime.now()).obs;
  DateTime dateSelect = DateTime.now();
  String gender = Gender.male.gender;
  late Calendar calendar = Calendar(Get.context!);

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
                    Text(
                      KeyLanguage.infoPerson.tr,
                      style: StyleUtils.titleLarge.copyWith(
                        color: Theme.of(Get.context!).canvasColor,
                      ),
                    ),
                    TextFieldWidget(
                      controller: phoneNumberController,
                      labelText: KeyLanguage.phone.tr,
                      validator: (value) {
                        return ValidationHelper.validPhoneNumber(value);
                      },
                    ),
                    TextFieldWidget(
                      controller: fullNameController,
                      labelText: KeyLanguage.fullname.tr,
                    ),
                    TextFieldWidget(
                      controller: addressController,
                      labelText: KeyLanguage.address.tr,
                    ),
                    Obx(() {
                      return TextFieldWidget(
                        controller: TextEditingController(text: dob.value),
                        labelText: KeyLanguage.dateOfBirth.tr,
                        readOnly: true,
                        isPasswordField: false,
                        validator: (value) {
                          return ValidationHelper.validDOB(value);
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            pickDOB();
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      );
                    }),
                    BirthPlaceDropdown(
                      label: KeyLanguage.birthPlace.tr,
                      items: AppConstant.birthPlaces,
                      onValueChanged: (newValue) {
                        selectedBirthPlace = newValue;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: DimensionUtils.PADDING_SIZE_SMALL,
                        left: DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${KeyLanguage.gender.tr} : ",
                            style: TextStyle(
                              color: Theme.of(context).canvasColor,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: RadioGender(
                              onValueChanged: (newValue) {
                                gender = newValue;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE,
                    ),
                    ButtonTextWidget(
                      label: KeyLanguage.completed.tr,
                      onTap: () {
                        complete();
                      },
                    ),
                    const SizedBox(
                      height:
                          DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER *
                          2 /
                          3,
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

  void complete() {
    String phoneNumber = phoneNumberController.text;
    String fullname = fullNameController.text;
    String address = addressController.text;
    if (form.currentState!.validate()) {
      log('đầy đủ thông tin');
      Get.find<LoadingController>().loading(
        handle: () async {
          user.setPhone = phoneNumber;
          user.setFullName = fullname;
          user.setAddress = address;
          user.setDateOfBirth = DateConvert.stringFormatToRequest(dob.value);
          user.setBirthPlace = selectedBirthPlace;
          user.setGender = gender;

          await Get.find<UserController>().createUser(user);

          Get.offAll(() => PickRoleScreen(user: user));
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

  Future<void> pickDOB() async {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SizedBox(
          height: Get.height * 0.4,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    debugPrint('click cancel');
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Text(
                      KeyLanguage.cancel.tr,
                      style: StyleUtils.styleDefault.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 20,
                child: InkWell(
                  onTap: () {
                    dob.value = DateConvert.dateTimeToString(dateSelect);
                    debugPrint('${dob.value}');
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Text(
                      KeyLanguage.agree.tr,
                      style: StyleUtils.styleDefault.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateConvert.stringToDateTime(dob.value),
                onDateTimeChanged: (DateTime newDateTime) {
                  dateSelect = newDateTime;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

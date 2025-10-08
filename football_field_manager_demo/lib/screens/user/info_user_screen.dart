import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/controller/loading_controller.dart';
import 'package:football_field_manager_demo/controller/user_controller.dart';
import 'package:football_field_manager_demo/data/models/request/user_update_request.dart';
import 'package:football_field_manager_demo/data/models/response/user_response.dart';
import 'package:football_field_manager_demo/screens/widgets/loading_widget.dart';
import 'package:football_field_manager_demo/views/custom_snackbar.dart';

import '../../utils/dimension_utils.dart';
import '../widgets/button_icon_widget.dart';
import '../widgets/text_field_widget.dart';

import 'package:get/get.dart';

class InfoUserScreen extends StatelessWidget {
  const InfoUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController(
      text: Get.find<UserController>().user?.fullName ?? "",
    );
    final TextEditingController phoneNumberController = TextEditingController(
      text: Get.find<UserController>().user?.phoneNumber ?? "",
    );
    final TextEditingController addressController = TextEditingController(
      text: Get.find<UserController>().user?.address ?? "",
    );

    final form = GlobalKey<FormState>();

    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Thông tin cá nhân"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      controller: fullNameController,
                      labelText: "Họ và tên",
                    ),
                    SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                    TextFieldWidget(
                      controller: phoneNumberController,
                      labelText: "Số điện thoại",
                    ),
                    SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                    TextFieldWidget(
                      controller: addressController,
                      labelText: "Địa chỉ",
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE,
                    ),
                    ButtonTextWidget(
                      label: "Lưu thay đổi",
                      onTap: () {
                        UserResponse? user = Get.find<UserController>().user;

                        UserUpdateRequest request = UserUpdateRequest(
                          fullName: fullNameController.text,
                          phoneNumber: phoneNumberController.text,
                          address: addressController.text,
                          dateOfBirth: user?.dateOfBirth ?? "",
                          gender: user?.gender ?? "",
                          hometown: user?.hometown ?? "",
                        );

                        Get.find<LoadingController>().loading(
                          handle: () async {
                            await Get.find<UserController>()
                                .updateUserById(user?.id ?? "", request)
                                .then((value) {
                                  if (value == 200) {
                                    showCustomSnackBar("Cập nhật thành công");
                                    Get.back();
                                  }
                                });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

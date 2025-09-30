// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import '../../../controller/authentication_controller.dart';
import '../../../controller/storage_controller.dart';
import '../../../controller/user_controller.dart';
import 'package:get/get.dart';
import '../../../data/models/request/multipart.dart';
import '../../../utils/language/key_language.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/dimension_utils.dart';
import '../../widgets/switch_widget.dart';
import '../widget/button_side_bar.dart';

class SideBarPage extends StatefulWidget {
  SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    Get.find<StorageController>().getImageUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 146, 112),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, bottom: 30),
        child: Stack(
          children: [
            GetBuilder<UserController>(
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: GetBuilder<StorageController>(
                        builder: (storageController) {
                          return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius:
                                DimensionUtils.BORDER_RADIUS_EXTRA_OVER_LARGE,
                            backgroundImage: storageController.image != null
                                ? MemoryImage(storageController.image!)
                                : null,
                            child: storageController.image == null
                                ? Icon(Icons.person)
                                : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.user!.fullName ?? KeyLanguage.nameManage.tr,
                      // ignore: prefer_const_constructors
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    Text(
                      controller.user!.username ?? KeyLanguage.username.tr,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Spacer(),
                    NewRow(
                      icon: Icons.align_vertical_bottom_outlined,
                      title: KeyLanguage.revenue.tr,
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    NewRow(
                      icon: Icons.message,
                      title: KeyLanguage.message.tr,
                      onTap: () {},
                    ),
                    Spacer(),
                    NewRow(
                      icon: Icons.cancel,
                      title: KeyLanguage.logout.tr,
                      onTap: () async {
                        Get.find<AuthenticationController>().logout();
                      },
                      isColor: true,
                    ),
                  ],
                );
              },
            ),
            Positioned(right: 0, child: SwitchWidget(isPitchOwner: true)),
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final resultImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (resultImage == null) return;

    selectedFile = File(resultImage.path);
    setState(() {
      Get.find<StorageController>().updateImage(
        selectedFile!.readAsBytesSync(),
      );
    });

    Get.find<StorageController>().uploadFile(Multipart(file: selectedFile));
  }
}

import 'package:flutter/material.dart';
import '../../controller/football_field_controller.dart';
import 'favorite_screen.dart';
import 'history_screen.dart';
import 'user_home_page_screen.dart';
import 'person_screen.dart';
import '../widgets/loading_widget.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/language/key_language.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // ignore: prefer_final_fields
  var _currentIndex = 0.obs;

  List<Widget> listWidget = [
    const UserHomePageScreen(),
    const HistoryScreen(),
    const FavoriteScreen(),
    const PersonScreen(),
  ];

  @override
  void dispose() {
    super.dispose();
    Get.find<FootballFieldController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Obx(
        () => Scaffold(
          backgroundColor: ColorConstant.getWhiteColor(),
          body: Container(child: listWidget[_currentIndex.value]),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex.value,
            onTap: (i) => _currentIndex.value = i,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.house),
                title: Text(KeyLanguage.house.tr),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.history),
                title: Text(KeyLanguage.history.tr),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite),
                title: Text(KeyLanguage.favorite.tr),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_rounded),
                title: Text(KeyLanguage.person.tr),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';

class SideBarController extends GetxController implements GetxService {
  SideBarController();

  bool _isOpenSideBar = false;
  double _xOffset = 0.0;
  double _yOffset = 0.0;

  bool get isOpenSideBar => _isOpenSideBar;
  double get xOffset => _xOffset;
  double get yOffset => _yOffset;

  void changeSideBar() {
    if (_isOpenSideBar) {
      clearData();
    } else {
      _xOffset = Get.width - 140;
      _yOffset = Get.height / 5;
      _isOpenSideBar = true;
    }

    update();
  }

  void clearData() {
    _xOffset = 0.0;
    _yOffset = 0.0;
    _isOpenSideBar = false;
  }
}

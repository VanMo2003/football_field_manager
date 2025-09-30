import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/helper/route_helper.dart';
import '../../../controller/user_controller.dart';
import '../../data/api/api_checker.dart';
import '../../data/models/response/api_response.dart';
import '../../data/models/response/authentication_response.dart';
import '../../data/models/response/introspect_response.dart';
import '../../data/repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../screens/widgets/dialog_question_widget.dart';
import '../utils/language/key_language.dart';
import 'loading_controller.dart';

enum AuthenticationStatus { authentication, un_authentication, unknown }

class AuthenticationController extends GetxController implements GetxService {
  final AuthenticationRepository authRepo;

  AuthenticationController({required this.authRepo});

  AuthenticationStatus _status = AuthenticationStatus.un_authentication;
  AuthenticationStatus get status => _status;

  Future<int> login(String username, String password) async {
    Response response = await authRepo.login(username, password);
    ApiResponse res = ApiResponse.fromJson(response.body);

    if (response.statusCode == 200) {
      _status = AuthenticationStatus.authentication;

      AuthenticationResponse? authentication = AuthenticationResponse.fromJson(
        res.data,
      );

      if (authentication.token != null) {
        Get.offNamed(RouteHelper.getHomeRoute());
        authRepo.saveUserToken(authentication.token);
      }
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    update();

    log(response.statusCode!.toString());

    return response.statusCode!;
  }

  void logout() async {
    showDialog(
      context: Get.context!,
      builder: (context) => DialogQuestionWidget(
        label: KeyLanguage.logout.tr,
        question: KeyLanguage.logoutQuestion.tr,
        agree: () {
          Get.find<LoadingController>().loading(
            handle: () async {
              Response response = await authRepo.logout();

              if (response.statusCode == 200) {
                clearData();
                Get.find<UserController>().clearData();
                authRepo.removeToken();
                update();
              } else {
                ApiChecker.apiChecker(response.statusCode!);
              }
            },
          );
        },
      ),
    );
  }

  Future<bool> introspect() async {
    Response response = await authRepo.introspect();

    bool valid =
        IntrospectResponse.fromJson(response.body["data"]).valid ?? false;

    return valid;
  }

  void refreshToken() async {
    Response response = await authRepo.refreshToken();

    if (response.statusCode == 200) {
      AuthenticationResponse? authentication = AuthenticationResponse.fromJson(
        response.body["data"],
      );

      if (authentication.token != null) {
        authRepo.saveUserToken(authentication.token!);
      }

      setStatus(AuthenticationStatus.authentication);
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }
  }

  void setStatus(AuthenticationStatus status) {
    _status = status;
    update();
  }

  void clearData() {
    _status = AuthenticationStatus.un_authentication;
  }
}

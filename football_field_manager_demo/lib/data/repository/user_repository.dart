import 'package:football_field_manager_demo/data/models/request/user_update_request.dart';

import '../../data/models/request/user_request.dart';
import '../../utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';

class UserRepository {
  UserRepository({required this.apiClient, required this.sharedPreferences});

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> createUser(User user) async {
    return await apiClient.postDataNoAuth(
      AppConstant.ENDPOINT_CREATE_USER,
      body: user,
    );
  }

  Future<Response> getMyInfo() async {
    return await apiClient.getData(AppConstant.ENDPOINT_GET_MY_INFO);
  }

  Future<Response> updateUserById(String userId, UserUpdateRequest request) async {
    return await apiClient.putData(
      "${AppConstant.ENDPOINT_UPDATE_USER_BY_ID}/$userId", request
    );
  }

  Future<Response> checkExistUser(String username) async {
    return await apiClient.getDataNoAuth(
      "${AppConstant.ENDPOINT_CHECK_EXIST_USER}/$username",
    );
  }

  String? getUserToken() {
    return sharedPreferences.getString(AppConstant.TOKEN);
  }
}

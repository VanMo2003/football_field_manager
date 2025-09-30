import '../../../controller/user_controller.dart';
import '../../data/api/api_client.dart';
import '../../data/models/request/multipart.dart';
import '../../data/models/response/user_response.dart';
import '../../utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  StorageRepository({required this.apiClient, required this.sharedPreferences});

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> uploadFile(Multipart multipart) async {
    String token = sharedPreferences.getString(AppConstant.TOKEN) ?? "";
    Map<String, String> header = {
      "Content-Type": "multipart/form-data",
      "Authorization": token,
    };
    return await apiClient.postMultipartData(
      AppConstant.ENDPOINT_UPLOAD_FILE,
      multipart,
      headers: header,
      filename: "${Get.find<UserController>().user!.id!}.png",
    );
  }

  Future<Response> getImageUser() async {
    UserResponse? user = Get.find<UserController>().user;
    return await apiClient.getDataNoAuth(
      "${AppConstant.ENDPOINT_GET_FILE_BY_NAME}/${user!.id}.png",
    );
  }
}

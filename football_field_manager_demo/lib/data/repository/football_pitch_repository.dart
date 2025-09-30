import '../../utils/app_constant.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class FootballPitchRepository {
  final ApiClient apiClient;

  FootballPitchRepository({required this.apiClient});

  Future<Response> getAllFootballPitches() async {
    return await apiClient.getData(
      AppConstant.ENDPOINT_GET_ALL_FOOTBALL_FIELD,
    );
  }
}

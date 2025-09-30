import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class TimeSlotRepository{
  final ApiClient apiClient;

  TimeSlotRepository({required this.apiClient});

  Future<Response> getAllTimeSlotByFootballField(int footballFieldId) async {
    return await apiClient.getData(
      "${AppConstant.ENDPOINT_GET_ALL_TIME_SLOT_BY_FOOTBALL_FIELD}=$footballFieldId",
    );
  }
}
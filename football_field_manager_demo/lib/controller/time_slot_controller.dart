import 'package:football_field_manager_demo/data/models/response/time_slot_response.dart';
import 'package:football_field_manager_demo/data/repository/time_slot_repository.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';

class TimeSlotController extends GetxController implements GetxService{
  final TimeSlotRepository timeSlotRepository;

  TimeSlotController({required this.timeSlotRepository});

  List<TimeSlotResponse>? _timeSlotResponse;

  List<TimeSlotResponse>? get timeSlotResponse => _timeSlotResponse;

  Future<int> getAllTimeSlotByFootballField(int footballFieldId) async {
    Response response = await timeSlotRepository.getAllTimeSlotByFootballField(footballFieldId);

    _timeSlotResponse ??= [];

    if (response.statusCode == 200) {
      for (var footballPitch in response.body["data"]) {
        _timeSlotResponse!.add(TimeSlotResponse.fromJson(footballPitch));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  void clearData(){
    _timeSlotResponse = null;
  }
}
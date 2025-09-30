import 'package:football_field_manager_demo/controller/booking_controller.dart';
import 'package:football_field_manager_demo/controller/time_slot_controller.dart';
import 'package:football_field_manager_demo/data/repository/booking_repository.dart';
import 'package:football_field_manager_demo/data/repository/time_slot_repository.dart';

import '../../controller/authentication_controller.dart';
import '../../controller/calendar_controller.dart';
import 'controller/football_field_controller.dart';
import '../../controller/langue_controller.dart';
import '../../controller/loading_controller.dart';
import '../../../controller/side_bar_controller.dart';

import '../../controller/storage_controller.dart';
import '../../../controller/user_controller.dart';
import '../../data/api/api_client.dart';
import '../../data/repository/authentication_repository.dart';
import '../../data/repository/football_pitch_repository.dart';
import '../../data/repository/storage_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/app_constant.dart';
import '../../theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'services/language_service.dart';

Future<void> binding() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LanguageService());
  Get.lazyPut(() => ApiClient(urlBase: AppConstant.URL_BASE, sharedPreferences: Get.find()));

  Get.lazyPut(() => AuthenticationRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => FootballPitchRepository(apiClient: Get.find()));
  Get.lazyPut(() => TimeSlotRepository(apiClient: Get.find()));
  Get.lazyPut(() => BookingRepository(apiClient: Get.find()));
  Get.lazyPut(() => StorageRepository(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LoadingController());
  Get.lazyPut(() => AuthenticationController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => FootballFieldController(footballPitchesRepository: Get.find()));
  Get.lazyPut(() => TimeSlotController(timeSlotRepository: Get.find()));
  Get.lazyPut(() => BookingController(bookingRepository: Get.find()));
  Get.lazyPut(() => StorageController(storageRepository: Get.find()));
  Get.lazyPut(() => SideBarController());
  Get.lazyPut(() => CalendarController());
}

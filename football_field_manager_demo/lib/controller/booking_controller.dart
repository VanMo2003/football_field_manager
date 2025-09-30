import 'package:football_field_manager_demo/controller/user_controller.dart';
import 'package:football_field_manager_demo/data/models/request/booking_request.dart';
import 'package:football_field_manager_demo/data/models/response/booking_response.dart';
import 'package:football_field_manager_demo/data/repository/booking_repository.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';

class BookingController extends GetxController implements GetxService{
  final BookingRepository bookingRepository;

  BookingController({required this.bookingRepository});

  List<BookingResponse>? _bookingResponse;
  List<BookingResponse>? _bookingByUsers;

  List<BookingResponse>? get bookingResponse => _bookingResponse;
  List<BookingResponse>? get bookingByUsers => _bookingByUsers;

  Future<int> getAllByFootballFieldAndBookingDate(int footballFieldId, String bookingDate) async {
    Response response = await bookingRepository.getAllByFootballFieldAndBookingDate(footballFieldId, bookingDate);

    _bookingResponse ??= [];

    if (response.statusCode == 200) {
      for (var booking in response.body["data"]) {
        _bookingResponse!.add(BookingResponse.fromJson(booking));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> createBooking(BookingRequest booking) async {
    Response response = await bookingRepository.createBooking(booking);

    _bookingResponse ??= [];

    if (response.statusCode == 200) {
      _bookingResponse!.add(BookingResponse.fromJson(response.body["data"]));
      _bookingByUsers ??= [];
      _bookingByUsers!.add(BookingResponse.fromJson(response.body["data"]));
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> getAllByUser() async {
    String phoneNumber = Get.find<UserController>().user?.phoneNumber ?? "";
    Response response = await bookingRepository.getAllByUser(phoneNumber);

    _bookingByUsers ??= [];

    if (response.statusCode == 200) {
      for (var booking in response.body["data"]) {
        _bookingByUsers!.add(BookingResponse.fromJson(booking));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  void clearData(){
    _bookingResponse = null;
    _bookingByUsers = null;
  }
}
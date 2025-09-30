import 'package:football_field_manager_demo/data/models/request/booking_request.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class BookingRepository{
  final ApiClient apiClient;

  BookingRepository({required this.apiClient});

  Future<Response> getAllByFootballFieldAndBookingDate(int footballFieldId, String bookingDate) async {
    return await apiClient.getData(
        "${AppConstant.ENDPOINT_GET_ALL_BOOKING_BY_FOOTBALL_FIELD_AND_BOOKING_DATE}/$footballFieldId/$bookingDate",
    );
  }

  Future<Response> createBooking(BookingRequest booking) async {
    return await apiClient.postData(
        AppConstant.ENDPOINT_CREATE_BOOKING,
        booking
    );
  }

  Future<Response> getAllByUser(String phoneNumber) async {
    return await apiClient.getData(
        "${AppConstant.ENDPOINT_GET_ALL_BY_USER}/$phoneNumber",
    );
  }
}
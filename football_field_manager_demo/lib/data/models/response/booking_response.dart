import 'package:football_field_manager_demo/data/models/response/football_pitch_response.dart';
import 'package:football_field_manager_demo/data/models/response/time_slot_response.dart';

class BookingResponse {
  int? id;
  String? orderCode;
  String? bookingDate;
  String? userPhoneNumber;
  int? pitchNumber;
  FootballFieldResponse? footballField;
  TimeSlotResponse? timeSlot;
  // List<Services>? services;
  String? bookingStatus;
  String? paymentStatus;
  int? price;
  String? onCreate;
  String? onUpdate;

  BookingResponse(
      {this.id,
        this.orderCode,
        this.bookingDate,
        this.userPhoneNumber,
        this.pitchNumber,
        this.footballField,
        this.timeSlot,
        // this.services,
        this.bookingStatus,
        this.paymentStatus,
        this.price,
        this.onCreate,
        this.onUpdate});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['orderCode'];
    bookingDate = json['bookingDate'];
    userPhoneNumber = json['userPhoneNumber'];
    pitchNumber = json['pitchNumber'];
    footballField = json['footballField'] != null
        ? new FootballFieldResponse.fromJson(json['footballField'])
        : null;
    timeSlot = json['timeSlot'] != null
        ? new TimeSlotResponse.fromJson(json['timeSlot'])
        : null;
    // if (json['services'] != null) {
    //   services = <Services>[];
    //   json['services'].forEach((v) {
    //     services!.add(new Services.fromJson(v));
    //   });
    // }
    bookingStatus = json['bookingStatus'];
    paymentStatus = json['paymentStatus'];
    price = json['price'];
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderCode'] = this.orderCode;
    data['bookingDate'] = this.bookingDate;
    data['userPhoneNumber'] = this.userPhoneNumber;
    data['pitchNumber'] = this.pitchNumber;
    if (this.footballField != null) {
      data['footballField'] = this.footballField!.toJson();
    }
    if (this.timeSlot != null) {
      data['timeSlot'] = this.timeSlot!.toJson();
    }
    // if (this.services != null) {
    //   data['services'] = this.services!.map((v) => v.toJson()).toList();
    // }
    data['bookingStatus'] = this.bookingStatus;
    data['paymentStatus'] = this.paymentStatus;
    data['price'] = this.price;
    data['onCreate'] = this.onCreate;
    data['onUpdate'] = this.onUpdate;
    return data;
  }
}
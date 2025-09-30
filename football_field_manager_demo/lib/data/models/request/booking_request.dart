class BookingRequest {
  String? userPhoneNumber;
  int? footballFieldId;
  String? bookingDate;
  int? timeSlotId;
  int? pitchNumber;
  List<int>? serviceIds;
  int? price;

  BookingRequest(
      {this.userPhoneNumber,
        this.footballFieldId,
        this.bookingDate,
        this.timeSlotId,
        this.pitchNumber,
        this.serviceIds,
        this.price});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    userPhoneNumber = json['userPhoneNumber'];
    bookingDate = json['bookingDate'];
    footballFieldId = json['footballFieldId'];
    timeSlotId = json['timeSlotId'];
    pitchNumber = json['pitchNumber'];
    serviceIds = json['serviceIds'].cast<int>();
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPhoneNumber'] = this.userPhoneNumber;
    data['bookingDate'] = this.bookingDate;
    data['footballFieldId'] = this.footballFieldId;
    data['timeSlotId'] = this.timeSlotId;
    data['pitchNumber'] = this.pitchNumber;
    data['serviceIds'] = this.serviceIds;
    data['price'] = this.price;
    return data;
  }
}
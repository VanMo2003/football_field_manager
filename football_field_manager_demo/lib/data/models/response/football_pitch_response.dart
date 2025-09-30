import 'time_slot_response.dart';
import 'user_response.dart';

class FootballFieldResponse {
  int? id;
  String? name;
  String? description;
  int? totalPitches;
  String? location;
  int? price;
  List<TimeSlotResponse>? timeSlots;
  bool? active;

  FootballFieldResponse({
    this.id,
    this.name,
    this.totalPitches,
    this.location,
    this.price,
    this.timeSlots,
    this.active,
  });

  FootballFieldResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalPitches = json['totalPitches'];
    location = json['location'];
    price = json['price'];
    // if (json['timeSlots'] != null) {
    //   timeSlots = <TimeSlotResponse>[];
    //   json['timeSlots'].forEach((v) {
    //     timeSlots!.add(TimeSlotResponse.fromJson(v));
    //   });
    // }
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['totalPitches'] = totalPitches;
    data['location'] = location;
    data['price'] = price;
    // if (timeSlots != null) {
    //   data['timeSlots'] = timeSlots!.map((v) => v.toJson()).toList();
    // }
    data['active'] = active;
    return data;
  }
}

class TimeSlotResponse {
  int? id;
  String? startTime;
  String? endTime;
  double? price;
  String? onCreate;
  String? onUpdate;

  TimeSlotResponse({this.id, this.startTime, this.endTime, this.price, this.onCreate, this.onUpdate});

  TimeSlotResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    price = json['price'];
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['price'] = this.price;
    data['onCreate'] = this.onCreate;
    data['onUpdate'] = this.onUpdate;
    return data;
  }
}

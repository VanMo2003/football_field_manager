class UserUpdateRequest {
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;
  String? hometown;
  String? address;

  UserUpdateRequest(
      {this.fullName,
        this.phoneNumber,
        this.gender,
        this.dateOfBirth,
        this.hometown,
        this.address});

  UserUpdateRequest.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    hometown = json['hometown'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['hometown'] = this.hometown;
    data['address'] = this.address;
    return data;
  }
}
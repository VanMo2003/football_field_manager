class User {
  String? username;
  String? password;
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;
  String? hometown;
  String? address;

  User({
    this.username,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.hometown,
    this.address,
  });

  void set setUsername(String username) {
    this.username = username;
  }

  void set setPassword(String password) {
    this.password = password;
  }

  void set setFullName(String fullName) {
    this.fullName = fullName;
  }

  void set setPhone(String phone) {
    this.phoneNumber = phone;
  }

  void set setGender(String gender) {
    this.gender = gender;
  }

  void set setDateOfBirth(String dateOfBirth) {
    this.dateOfBirth = dateOfBirth;
  }

  void set setBirthPlace(String birthPlace) {
    this.hometown = birthPlace;
  }

  void set setAddress(String address) {
    this.address = address;
  }

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    fullName = json['fullName'];
    phoneNumber = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    hometown = json['birthPlace'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['phone'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['birthPlace'] = this.hometown;
    data['address'] = this.address;
    return data;
  }

  User copyWith({
    String? username,
    String? password,
    String? fullName,
    String? phone,
    String? gender,
    String? dateOfBirth,
    String? birthPlace,
    String? address,
    List<String>? roles,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNumber: phone ?? this.phoneNumber,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      hometown: birthPlace ?? this.hometown,
      address: address ?? this.address,
    );
  }
}

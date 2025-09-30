class AppConstant {
  static const URL_BASE = "http://10.0.2.2:8080/ffm";
  static const URL_BASE_WEB = "http://localhost:8080/ffm";
  static const ENDPOINT_LOGIN = "/auth/login";
  static const ENDPOINT_LOGOUT = "/auth/logout";
  static const ENDPOINT_INTROSPECT = "/auth/introspect";
  static const ENDPOINT_REFRESH_TOKEN = "/auth/refreshToken";
  static const ENDPOINT_CREATE_USER = "/user";
  static const ENDPOINT_GET_MY_INFO = "/user/getMyInfo";
  static const ENDPOINT_UPDATE_USER_BY_ID = "/user";
  static const ENDPOINT_CHECK_EXIST_USER = "/user/checkExistUser";
  static const ENDPOINT_GET_ALL_FOOTBALL_FIELD = "/football-field";
  static const ENDPOINT_GET_ALL_TIME_SLOT_BY_FOOTBALL_FIELD = "/timeslot?football_field_id";
  static const ENDPOINT_CREATE_BOOKING = "/booking";
  static const ENDPOINT_GET_ALL_BY_USER = "/booking/getAllByUser";
  static const ENDPOINT_GET_ALL_BOOKING_BY_FOOTBALL_FIELD_AND_BOOKING_DATE = "/booking/getAllBookingByBookingDate";
  static const ENDPOINT_UPLOAD_FILE = "/storage/upload";
  static const ENDPOINT_GET_FILE_BY_NAME = "/storage";

  static const APP_NAME = "football field management";

  static const LANGUAGE_CODE = "vm_language";
  static const String THEME = 'vm_theme';
  static const String TOKEN = 'vm_token';

  static const List<String> birthPlaces = [
    "An Giang",
    "Hà Giang",
    "Cao Bằng",
    "Lào Cai",
    "Sơn La",
    "Lai Châu",
    "Bắc Kạn",
    "Lạng Sơn",
    "Tuyên Quang",
    "Yên Bái",
    "Thái Nguyên",
    "Điện Biên",
    "Phú Thọ",
    "Vĩnh Phúc",
    "Bắc Giang",
    "Bắc Ninh",
    "Hà Nội",
    "Quảng Ninh",
    "Hải Dương",
    "Hải Phòng",
    "Hòa Bình",
    "Hưng Yên",
    "Hà Nam",
    "Thái Bình",
    "Nam Định",
    "Ninh Bình",
    "Thanh Hóa",
    "Nghệ An",
    "Hà Tĩnh",
    "Quảng Bình",
    "Quảng Trị",
    "Thừa Thiên Huế",
    "Đà Nẵng",
    "Quảng Nam",
    "Quảng Ngãi",
    "Kon Tum",
    "Gia Lai",
    "Bình Định",
    "Phú Yên",
    "Đắk Lắk",
    "Khánh Hòa",
    "Đắk Nông",
    "Lâm Đồng",
    "Ninh Thuận",
    "Bình Phước",
    "Tây Ninh",
    "Bình Dương",
    "Đồng Nai",
    "Bình Thuận",
    "Thành phố Hồ Chí Minh",
    "Long An",
    "Bà Rịa–Vũng Tàu",
    "Đồng Tháp",
    "Tiền Giang",
    "Vĩnh Long",
    "Bến Tre",
    "Cần Thơ",
    "Kiên Giang",
    "Trà Vinh",
    "Hậu Giang",
    "Sóc Trăng",
    "Bạc Liêu",
    "Cà Mau",
  ];
}

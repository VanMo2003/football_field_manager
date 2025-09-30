import 'dart:io';

class Multipart {
  String key;
  File? file;

  Multipart({this.key = "image", required this.file});
}

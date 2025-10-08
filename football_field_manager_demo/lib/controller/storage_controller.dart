import 'dart:typed_data';

import '../../data/models/request/multipart.dart';
import '../../data/repository/storage_repository.dart';
import '../../../utils/language/key_language.dart';
import '../../views/custom_snackbar.dart';
import 'package:get/get.dart';

class StorageController extends GetxController implements GetxService {
  StorageController({required this.storageRepository});

  final StorageRepository storageRepository;

  Uint8List? _image;

  Uint8List? get image => _image;

  Future<int> uploadFile(Multipart multipart) async {
    Response response = await storageRepository.uploadFile(multipart);

    if (response.statusCode == 200) {
      showCustomSnackBar(KeyLanguage.updateImage.tr);
    } else {
      showCustomSnackBar("lỗi", isError: true);
    }
    update();

    return response.statusCode!;
  }

  Future<int> getImageUser() async {
    Response response = await storageRepository.getImageUser();

    if (response.statusCode == 200) {
      _image = Uint8List.fromList(response.body.codeUnits);
    } else {
      showCustomSnackBar("lỗi", isError: true);
    }
    update();

    return response.statusCode!;
  }

  void updateImage(Uint8List image) {
    _image = image;
    update();
  }

  void clearData() {
    _image = null;
  }
}

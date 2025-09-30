import '../../data/api/api_checker.dart';
import '../../data/models/response/football_pitch_response.dart';
import '../../data/repository/football_pitch_repository.dart';
import 'package:get/get.dart';

class FootballFieldController extends GetxController implements GetxService {
  FootballFieldController({required this.footballPitchesRepository});

  final FootballPitchRepository footballPitchesRepository;

  bool _loading = true;
  FootballFieldResponse? _footballField;
  List<FootballFieldResponse>? _footballFields;

  bool get loading => _loading;
  FootballFieldResponse? get footballPitch => _footballField;
  List<FootballFieldResponse>? get footballFields => _footballFields;

  Future<int> getAllFootballFields() async {
    Response response = await footballPitchesRepository.getAllFootballPitches();

    _footballFields ??= [];

    if (response.statusCode == 200) {
      for (var footballPitch in response.body["data"]) {
        _footballFields!.add(FootballFieldResponse.fromJson(footballPitch));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  void setFootballField(FootballFieldResponse footballFieldNew){
    _footballField = footballFieldNew;
  }

  void noLoading() {
    _loading = false;
    update();
  }

  void clearFootballField() {
    _footballField = null;
  }

  void clearData() {
    _footballField = null;
    _footballFields = null;
  }
}

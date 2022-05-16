import 'package:flutter/widgets.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/response_model.dart';
import 'package:serviceq/data/model/response/ulasan_model.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:serviceq/data/repository/ulasan_repo.dart';

class UlasanProvider extends ChangeNotifier {
  final UlasanRepo ulasanRepo;
  final SharedPreferences sharedPreferences;

  UlasanProvider({@required this.ulasanRepo, @required this.sharedPreferences});

  bool _isLoading = false;
  List<UlasanModel> _ulasanList;

  bool get isLoading => _isLoading;
  List<UlasanModel> get ulasanList => _ulasanList;

  Future<void> init() {
    _isLoading = false;
  }

  Future<void> getUlasanList() async {
    _isLoading = true;
    ApiResponse apiResponse = await ulasanRepo.getUlasanList();
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      if (data['success']) {
        _ulasanList = [];
        data['data'].forEach(
          (ulasan) => _ulasanList.add(
            UlasanModel.fromJson(ulasan),
          ),
        );
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<ResponseModel> postUlasan(int bengkelId, String ulasan) async {
    _isLoading = true;
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString(AppConstants.ID_USER),
      "bengkel_id": bengkelId,
      "ulasan": ulasan,
    };
    ResponseModel responseModel;
    ApiResponse apiResponse = await ulasanRepo.postUlasan(data);
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      responseModel =
          ResponseModel(data['success'], apiResponse.response.data['message']);
      _isLoading = false;
      notifyListeners();
    } else {
      responseModel =
          ResponseModel(data['success'], apiResponse.response.data['message']);
      _isLoading = false;
      notifyListeners();
    }
    return responseModel;
  }
}

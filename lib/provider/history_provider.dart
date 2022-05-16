import 'package:flutter/widgets.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/bengkel_model.dart';
import 'package:serviceq/data/model/response/response_model.dart';
import 'package:serviceq/data/repository/history_repo.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  final HistoryRepo historyRepo;
  final SharedPreferences sharedPreferences;
  HistoryProvider({@required this.historyRepo, this.sharedPreferences});

  List<BengkelModel> _historyList;
  bool _isLoading;

  List<BengkelModel> get historyList => _historyList;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = false;
  }

  Future<void> getHistroyList() async {
    _isLoading = true;
    ApiResponse apiResponse = await historyRepo.getHistoryList();

    if (apiResponse.response.statusCode == 200) {
      if (apiResponse.response.data != null) {
        _historyList = [];
        print('response history >> ${apiResponse.response.data['data']}');
        apiResponse.response.data['data'].forEach((bengkel) {
          _historyList.add(BengkelModel.fromJson(bengkel));
        });
      } else {
        _historyList = [];
      }
    } else {
      _historyList = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<ResponseModel> addHistory(String bengkelId, bool rekomendasi) async {
    final data = {
      "user_id": sharedPreferences.getString(AppConstants.ID_USER),
      "bengkel_id": bengkelId,
      "rekomendasi": rekomendasi.toString(),
    };
    ResponseModel responseModel;
    ApiResponse apiResponse = await historyRepo.addHistory(data);
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data['data'];
      print('resonse >> $data');
    } else {
      print('error');
    }
    return responseModel;
  }
}

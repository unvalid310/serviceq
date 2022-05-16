import 'package:flutter/widgets.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/response_model.dart';
import 'package:serviceq/data/repository/filter_repo.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterProvider extends ChangeNotifier {
  final FilterRepo filterRepo;
  final SharedPreferences sharedPreferences;
  FilterProvider({@required this.filterRepo, @required this.sharedPreferences});

  bool _isLoading;
  String _filter;

  bool get isLoading => _isLoading;
  String get filter => _filter;

  Future<void> init() async {
    _isLoading = false;
    _filter = '';
    ApiResponse apiResponse = await filterRepo.getFilter();
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data['data'];
      if (data != null) {
        _filter = data['tipe'].toString();
      } else {
        _filter = 'Filter data belum dipilih';
      }
      notifyListeners();
    }
  }

  Future<ResponseModel> addFilter(String tipeId) async {
    ResponseModel responseModel;
    ApiResponse apiResponse = await filterRepo.createFilter(tipeId);
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      responseModel = ResponseModel(data['success'], data['message']);
    }
    return responseModel;
  }
}

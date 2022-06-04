import 'package:flutter/cupertino.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/favorit_model.dart';
import 'package:serviceq/data/model/response/response_model.dart';
import 'package:serviceq/data/repository/favorit_repo.dart';

class FavoritProvider extends ChangeNotifier {
  final FavoritRepo favoritRepo;

  FavoritProvider({@required this.favoritRepo});

  bool _isLoading;
  FavoritModel _favoritList;
  String _message;

  bool get isLoading => _isLoading;
  FavoritModel get favoritList => _favoritList;
  String get message => _message;

  Future<void> getFavorit() async {
    _isLoading = true;
    ApiResponse apiResponse = await favoritRepo.getFavorit();
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      if (data['success']) {
        _favoritList = FavoritModel.fromJson(data['data']);
        _message = data['message'].toString();
      } else {
        _favoritList = null;
        _message = data['message'];
      }
    } else {
      _favoritList = null;
      _message = 'Terjadi Kesalahan';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<ResponseModel> postFavorit({String lokasi, String sparepart}) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse =
        await favoritRepo.postFavorit(lokasi: lokasi, sparepart: sparepart);
    if (apiResponse.response.statusCode == 200) {
      final status = apiResponse.response.data['success'];
      final message = apiResponse.response.data['message'];
      if (status) {
        responseModel = ResponseModel(status, message);
      } else {
        responseModel = ResponseModel(status, message);
      }
    } else {
      responseModel = ResponseModel(false, 'Terjadi kesalahan server');
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}

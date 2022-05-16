import 'package:flutter/cupertino.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/response_model.dart';
import 'package:serviceq/data/repository/rating_repo.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingProvider extends ChangeNotifier {
  final RatingRepo ratingRepo;
  final SharedPreferences sharedPreferences;

  RatingProvider({@required this.ratingRepo, @required this.sharedPreferences});

  bool _isLoading = false;
  Map<String, dynamic> _result;

  bool get isLoading => _isLoading;
  Map<String, dynamic> get result => _result;

  Future<void> init() {
    _isLoading = false;
  }

  Future<ResponseModel> postRating(int bengkelId, double rating) async {
    _isLoading = true;
    ResponseModel responseModel;
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString(AppConstants.ID_USER),
      "bengkel_id": bengkelId,
      "rating": rating,
    };
    ApiResponse apiResponse = await ratingRepo.postRating(data);
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

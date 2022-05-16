import 'package:flutter/foundation.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/response_model.dart';
import 'package:serviceq/data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({@required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _registrationErrorMessage = '';

  String get registrationErrorMessage => _registrationErrorMessage;

  void clearRegistrationErrorMessage() {
    _isLoading = false;
    _registrationErrorMessage = '';
  }

  updateRegistrationErrorMessage(String message) {
    _registrationErrorMessage = message;
    notifyListeners();
  }

  Future<ResponseModel> registration(
      String email, String username, String password, int role) async {
    _isLoading = true;
    _registrationErrorMessage = '';
    ResponseModel responseModel;
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.registration(email, username, password, role);
    if (apiResponse != null) {
      if (apiResponse.response.data['success']) {
        Map<String, dynamic> data = apiResponse.response.data;
        responseModel = ResponseModel(
            data['success'], apiResponse.response.data['message']);
      } else {
        responseModel = ResponseModel(apiResponse.response.data['success'],
            apiResponse.response.data['message']);
      }
      _isLoading = false;
      notifyListeners();
    } else {
      responseModel =
          ResponseModel(false, apiResponse.response.data['message'].toString());
      _isLoading = false;
      notifyListeners();
    }
    return responseModel;
  }

  Future<ResponseModel> login(String username, String password) async {
    _isLoading = true;
    _registrationErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(username, password);
    ResponseModel responseModel;
    if (apiResponse != null) {
      if (apiResponse.response.data['success']) {
        Map<String, dynamic> data = apiResponse.response.data['data'];
        await authRepo.saveUserData(
            int.parse(data['id']), data['username'], data['email']);
        responseModel = ResponseModel(apiResponse.response.data['success'],
            apiResponse.response.data['message']);
      } else {
        responseModel = ResponseModel(apiResponse.response.data['success'],
            apiResponse.response.data['message']);
      }
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> logout() async {
    bool status = false;
    status = await authRepo.clearSharedData().then((value) {
      return value;
    });
    return status;
  }
}

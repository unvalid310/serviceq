import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> registration(
      String email, String username, String password, int role) async {
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTER_URI,
        data: {
          'email': email,
          'username': username,
          'password': password,
          'role': role
        },
      ).timeout(const Duration(seconds: 10));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(
          ApiErrorHandler.getMessage('Terjadi kesalahan'));
    }
  }

  Future<void> saveUserData(int idUser, String username, String email) async {
    try {
      sharedPreferences.setString(AppConstants.ID_USER, idUser.toString());
      sharedPreferences.setString(AppConstants.USERNAME, username);
      sharedPreferences.setString(AppConstants.EMAIL, email);
    } catch (e) {}
  }

  Future<ApiResponse> login(String username, String password) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: {"username": username, "password": password, "role": 1},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for verify phone number
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.ID_USER);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.ID_USER);
    await sharedPreferences.remove(AppConstants.USERNAME);
    await sharedPreferences.remove(AppConstants.EMAIL);
    await sharedPreferences.remove(AppConstants.FILTER);
    return true;
  }
}

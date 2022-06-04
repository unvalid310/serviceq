import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LokasiRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LokasiRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getLokasi() async {
    try {
      final response = await dioClient.get(AppConstants.LOKASI_URI);
      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}

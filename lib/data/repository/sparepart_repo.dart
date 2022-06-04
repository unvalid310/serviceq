import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SparepartRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  SparepartRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getSparepart() async {
    try {
      final response = await dioClient.get(AppConstants.SPAREPART_URI);
      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}

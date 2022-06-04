import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RekomendasiRepo {
  final Dio dioClient;
  final SharedPreferences sharedPreferences;
  RekomendasiRepo({
    @required this.dioClient,
    @required this.sharedPreferences,
  });

  Future<ApiResponse> getRekomendasiList() async {
    try {
      final response = await dioClient.get(
        AppConstants.REKOMENDASI_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
        },
      );
      print('response>> ${response}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

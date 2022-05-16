import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  RatingRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> postRating(Map<String, dynamic> data) async {
    try {
      Response response =
          await dioClient.post(AppConstants.RATING_URI, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

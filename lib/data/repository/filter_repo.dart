import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FilterRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getFilter() async {
    try {
      final response = await dioClient.get(
        AppConstants.FILTER_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> createFilter(String tipeId) async {
    try {
      final response = await dioClient.post(
        AppConstants.FILTER_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER)
        },
        data: {'tipe_id': tipeId},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteFilter() async {
    try {
      final response = await dioClient.post(
        AppConstants.FILTER_URI + '/delete',
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER)
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

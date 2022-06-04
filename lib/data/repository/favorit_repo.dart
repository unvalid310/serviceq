import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:serviceq/data/datasource/remote/dio/dio_client.dart';
import 'package:serviceq/data/datasource/remote/exception/api_error_handler.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FavoritRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getFavorit() async {
    try {
      final response = await dioClient.get(
        AppConstants.FAVORIT_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER)
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> postFavorit({String lokasi, String sparepart}) async {
    try {
      final data = {
        'user_id': sharedPreferences.getString(AppConstants.ID_USER),
        'lokasi': lokasi,
        'sparepart': sparepart,
      };
      final response = await dioClient.post(
        AppConstants.FAVORIT_URI,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

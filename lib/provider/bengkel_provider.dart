import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/bengkel_model.dart';
import 'package:serviceq/data/repository/bengkel_repo.dart';

class BengkelProvider extends ChangeNotifier {
  final BengkelRepo bengkelRepo;

  BengkelProvider({@required this.bengkelRepo});

  List<BengkelModel> _bengkelList;
  bool _isLoading;

  List<BengkelModel> get bengkelList => _bengkelList;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = false;
  }

  Future<void> getBengekList() async {
    _isLoading = true;
    ApiResponse apiResponse = await bengkelRepo.getBengkelList();
    if (apiResponse.response.statusCode == 200) {
      if (apiResponse.response.data != null) {
        _bengkelList = [];
        apiResponse.response.data['data'].forEach((bengkel) {
          _bengkelList.add(BengkelModel.fromJson(bengkel));
        });
      } else {
        _bengkelList = [];
      }
    } else {
      _bengkelList = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}

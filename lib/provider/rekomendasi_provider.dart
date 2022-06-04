import 'package:flutter/material.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/bengkel_model.dart';
import 'package:serviceq/data/repository/rekomendasi_repo.dart';

class RekomendasiProvider extends ChangeNotifier {
  final RekomendasiRepo rekomendasiRepo;

  RekomendasiProvider({@required this.rekomendasiRepo});

  List<BengkelModel> _bengkelList;
  bool _isLoading;
  String _message;

  List<BengkelModel> get bengkelList => _bengkelList;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> init() async {
    _isLoading = false;
  }

  Future<void> getRekomendasiList() async {
    _isLoading = true;
    ApiResponse apiResponse = await rekomendasiRepo.getRekomendasiList();
    if (apiResponse.response.statusCode == 200) {
      if (apiResponse.response.data['data'] != null) {
        _bengkelList = [];
        apiResponse.response.data['data'].forEach((bengkel) {
          _bengkelList.add(BengkelModel.fromJson(bengkel));
        });
        _message = apiResponse.response.data['message'].toString();
      } else {
        _bengkelList = [];
        _message = apiResponse.response.data['message'].toString();
      }
    } else {
      _bengkelList = [];
      _message = "Terjadi Kesalahan";
    }
    _isLoading = false;
    notifyListeners();
  }
}

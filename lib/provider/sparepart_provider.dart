import 'package:flutter/cupertino.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/sparepart_%20model.dart';
import 'package:serviceq/data/repository/sparepart_repo.dart';

class SparepartProvider extends ChangeNotifier {
  final SparepartRepo sparepartRepo;

  SparepartProvider({@required this.sparepartRepo});

  bool _isLoading;
  List<SparepartModel> _sparepartList;
  String _message;

  bool get isLoading => _isLoading;
  List<SparepartModel> get sparepartList => _sparepartList;
  String get message => _message;

  Future<void> getSparepart() async {
    _isLoading = false;
    ApiResponse apiResponse = await sparepartRepo.getSparepart();
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      if (data['success']) {
        _sparepartList = [];
        data['data'].forEach((sparepart) =>
            _sparepartList.add(SparepartModel.fromJson(sparepart)));
        _message = data['message'];
      } else {
        _sparepartList = [];
        _message = data['message'];
      }
    } else {
      _sparepartList = [];
      _message = 'Terjadi Kesalahan';
    }
    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/lokasi_model.dart';
import 'package:serviceq/data/repository/lokasi_repo.dart';

class LokasiProvider extends ChangeNotifier {
  final LokasiRepo lokasiRepo;

  LokasiProvider({@required this.lokasiRepo});

  bool _isLoading;
  List<LokasiModel> _lokasiList;
  String _message;

  bool get isLoading => _isLoading;
  List<LokasiModel> get lokasiList => _lokasiList;
  String get message => _message;

  Future<void> getLokasi() async {
    _isLoading = true;
    ApiResponse apiResponse = await lokasiRepo.getLokasi();
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      if (data['success']) {
        _lokasiList = [];
        data['data']
            .forEach((lokasi) => _lokasiList.add(LokasiModel.fromJson(lokasi)));
        _message = data['message'].toString();
      } else {
        _lokasiList = [];
        _message = data['message'].toString();
      }
    } else {
      _lokasiList = [];
      _message = 'Terjadi Kesalahan';
    }
    _isLoading = false;
    notifyListeners();
  }
}

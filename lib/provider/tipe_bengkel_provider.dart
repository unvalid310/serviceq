import 'package:flutter/widgets.dart';
import 'package:serviceq/data/model/response/base/api_response.dart';
import 'package:serviceq/data/model/response/tipe_bengkel_model.dart';
import 'package:serviceq/data/repository/tipe_bengkel_repo.dart';

class TipeBengkelProvider extends ChangeNotifier {
  final TipeBengkelRepo tipeBengkelRepo;

  TipeBengkelProvider({@required this.tipeBengkelRepo});

  List<TipeBengkelModel> _tipeBengkelList;
  bool _isLoading;

  List<TipeBengkelModel> get tipeBengkelList => _tipeBengkelList;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = false;
  }

  Future<void> getTipeBengkel() async {
    _isLoading = false;
    _tipeBengkelList = [];
    ApiResponse apiResponse = await tipeBengkelRepo.getTipeBengkelList();
    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      if (data['success']) {
        data['data'].forEach(
          (tipeBengkel) =>
              _tipeBengkelList.add(TipeBengkelModel.fromJson(tipeBengkel)),
        );
      } else {
        _tipeBengkelList = [];
      }
    } else {
      _tipeBengkelList = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}

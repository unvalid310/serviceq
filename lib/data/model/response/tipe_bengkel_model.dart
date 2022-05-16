class TipeBengkelModel {
  int _id;
  String _tipe;

  TipeBengkelModel({
    int id,
    String tipe,
  }) {
    this._id = id;
    this._tipe = tipe;
  }

  int get id => _id;
  String get tipe => _tipe;

  TipeBengkelModel.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['tipe'] = this._tipe;
    return data;
  }
}

class FavoritModel {
  int _id;
  String _lokasi;
  String _sparepart;

  FavoritModel({
    int id,
    String lokasi,
    String sparepart,
  }) {
    this._id = id;
    this._lokasi = lokasi;
    this._sparepart = sparepart;
  }

  int get id => _id;
  String get lokasi => _lokasi;
  String get sparepart => _sparepart;

  FavoritModel.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _lokasi = (json['lokasi'] != null) ? json['lokasi'].toString() : null;
    _sparepart =
        (json['sparepart'] != null) ? json['sparepart'].toString() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['lokasi'] = (this._lokasi != null) ? this._lokasi : null;
    data['sparepart'] = this._sparepart;
    return data;
  }
}

class SparepartModel {
  int _id;
  String _sparepart;

  SparepartModel({
    int id,
    String sparepart,
  }) {
    this._id = id;
    this._sparepart = sparepart;
  }

  int get id => _id;
  String get sparepart => _sparepart;

  SparepartModel.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _sparepart = json['sparepart'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['sparepart'] = this._sparepart;
  }
}

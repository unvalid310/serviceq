import 'package:serviceq/data/model/response/ulasan_model.dart';

class BengkelModel {
  int _id;
  String _nama;
  String _deskripsi;
  String _alamat;
  String _jamBuka;
  String _noTelp;
  String _foto;
  int _userId;
  int _tipeId;
  String _tipe;
  double _rating;
  bool _rekomendasi;
  List<UlasanModel> _ulasan;

  BengkelModel({
    int id,
    String nama,
    String deskripsi,
    String alamat,
    String jamBuka,
    String noTelp,
    String foto,
    int userId,
    int tipeId,
    String tipe,
    double rating,
    bool rekomendasi,
    // List<UlasanModel> ulasan,
  }) {
    this._id = id;
    this._nama = nama;
    this._deskripsi = deskripsi;
    this._alamat = alamat;
    this._noTelp = noTelp;
    this._foto = foto;
    this._userId = userId;
    this._tipeId = tipeId;
    this._tipe = tipe;
    this._rating = rating;
    this._rekomendasi = rekomendasi;
    this._ulasan = ulasan;
  }

  int get id => _id;
  String get nama => _nama;
  String get deskripsi => _deskripsi;
  String get alamat => _alamat;
  String get jamBuka => _jamBuka;
  String get noTelp => _noTelp;
  String get foto => _foto;
  int get userId => _userId;
  int get tipeId => _tipeId;
  String get tipe => _tipe;
  double get rating => _rating;
  bool get rekomendasi => _rekomendasi;
  List<UlasanModel> get ulasan => _ulasan;

  BengkelModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nama = json['nama'].toString();
    _deskripsi = json['deskripsi'].toString();
    _alamat = json['alamat'].toString();
    _jamBuka = json['jam_buka'].toString();
    _noTelp = json['no_telp'].toString();
    _foto = json['foto'].toString();
    _userId = json['user_id'];
    _tipeId = json['tipe_id'];
    _tipe = json['tipe'].toString();
    _rating = double.parse(json['rating'].toString());
    _rekomendasi = json['rekomendasi'];
    if (json['ulasan'] != null) {
      _ulasan = [];
      json['ulasan'].forEach((v) {
        _ulasan.add(UlasanModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nama'] = this._nama;
    data['deskripsi'] = this._deskripsi;
    data['alamat'] = this._alamat;
    data['jam_buka'] = this._jamBuka;
    data['no_telp'] = this._noTelp;
    data['foto'] = this._foto;
    data['user_id'] = this._userId;
    data['tipe_id'] = this._tipeId;
    data['tipe'] = this._tipe;
    data['rating'] = this._rating;
    data['rekomendasi'] = this._rekomendasi;
    if (data['ulasan'] != null) {
      data['ulasan'] = this._ulasan.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

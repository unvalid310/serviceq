class UlasanModel {
  int _id;
  int _userId;
  String _username;
  int _bengkelId;
  String _ulasan;
  String _createdAt;

  UlasanModel({
    int id,
    int userId,
    int bengkelId,
    String username,
    String ulasan,
    String createdAt,
  }) {
    this._id = id;
    this._userId = userId;
    this._username = username;
    this._bengkelId = bengkelId;
    this._ulasan = ulasan;
    this._createdAt = createdAt;
  }

  int get id => _id;
  int get userId => _userId;
  String get username => _username;
  int get bengkelId => _bengkelId;
  String get ulasan => _ulasan;
  String get createdAt => _createdAt;

  UlasanModel.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _userId = int.parse(json['user_id'].toString());
    _username = json['username'].toString();
    _bengkelId = int.parse(json['bengkel_id'].toString());
    _ulasan = json['ulasan'].toString();
    _createdAt = json['created_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['username'] = this._username;
    data['bengkel_id'] = this._bengkelId;
    data['ulasan'] = this._ulasan;
    data['created_at'] = this._createdAt;
    return data;
  }
}

class LoginModel {
  int _id;
  String _userName;

  LoginModel({
    int id,
    String userName,
  }) {
    this._id = id;
    this._userName = userName;
  }

  int get id => _id;
  String get userName => _userName;

  LoginModel.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _userName = json['id_user'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['username'] = this._userName;
    return data;
  }
}

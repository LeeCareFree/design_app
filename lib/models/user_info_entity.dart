class UserInfoEntity {
  String sId;
  String username;
  String password;
  int iV;

  UserInfoEntity({this.sId, this.username, this.password, this.iV});

  UserInfoEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    password = json['password'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['__v'] = this.iV;
    return data;
  }
}
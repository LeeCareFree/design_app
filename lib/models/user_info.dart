class UserInfo {
  String token;
  String username;
  String uid;
  String avatar;

  UserInfo({this.token, this.username, this.uid, this.avatar});

  UserInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
    uid = json['uid'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['username'] = this.username;
    data['uid'] = this.uid;
    data['avatar'] = this.avatar;
    return data;
  }
}

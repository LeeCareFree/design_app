class UserInfo {
  String token;
  String username;

  UserInfo({this.token, this.username});

  UserInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['username'] = this.username;
    return data;
  }
}

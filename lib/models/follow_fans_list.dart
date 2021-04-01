class FollowFansList {
  List<Result> result;

  FollowFansList({this.result});

  FollowFansList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String avatar;
  String nickname;
  String username;
  String uid;
  bool isFocus;

  Result({this.avatar, this.nickname, this.username, this.uid, this.isFocus});

  Result.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nickname = json['nickname'];
    username = json['username'];
    uid = json['uid'];
    isFocus = json['isFocus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['username'] = this.username;
    data['uid'] = this.uid;
    data['isFocus'] = this.isFocus;
    return data;
  }
}

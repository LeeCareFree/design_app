class ChatList {
  List<Result> result;

  ChatList({this.result});

  ChatList.fromJson(Map<String, dynamic> json) {
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
  String uid;
  String avatar;
  String nickname;
  String lastTime;
  String lastMessage;

  Result(
      {this.uid, this.avatar, this.nickname, this.lastTime, this.lastMessage});

  Result.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    lastTime = json['lastTime'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['lastTime'] = this.lastTime;
    data['lastMessage'] = this.lastMessage;
    return data;
  }
}

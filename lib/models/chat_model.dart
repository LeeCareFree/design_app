class ChatModel {
  String avatar;
  String nickname;
  String uid;
  String message;
  String time;

  ChatModel({this.avatar, this.nickname, this.uid, this.message, this.time});

  ChatModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nickname = json['nickname'];
    uid = json['uid'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['uid'] = this.uid;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}

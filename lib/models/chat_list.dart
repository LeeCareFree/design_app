class ChatList {
  List<Detaillist> detaillist;
  String uid2;

  ChatList({this.detaillist, this.uid2});

  ChatList.fromJson(Map<String, dynamic> json) {
    if (json['detaillist'] != null) {
      detaillist = new List<Detaillist>();
      json['detaillist'].forEach((v) {
        detaillist.add(new Detaillist.fromJson(v));
      });
    }
    uid2 = json['uid2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detaillist != null) {
      data['detaillist'] = this.detaillist.map((v) => v.toJson()).toList();
    }
    data['uid2'] = this.uid2;
    return data;
  }
}

class Detaillist {
  String uid;
  String nickname;
  String avatar;
  String message;
  int time;

  Detaillist({this.uid, this.nickname, this.avatar, this.message, this.time});

  Detaillist.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}

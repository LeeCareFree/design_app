class MessageList {
  List<Messlist> messlist;
  int sum;

  MessageList({this.messlist, this.sum});

  MessageList.fromJson(Map<String, dynamic> json) {
    if (json['messlist'] != null) {
      messlist = new List<Messlist>();
      json['messlist'].forEach((v) {
        messlist.add(new Messlist.fromJson(v));
      });
    }
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messlist != null) {
      data['messlist'] = this.messlist.map((v) => v.toJson()).toList();
    }
    data['sum'] = this.sum;
    return data;
  }
}

class Messlist {
  String uid;
  String nickname;
  String avatar;
  String message;
  int messNum;
  String time;

  Messlist({this.uid, this.nickname, this.avatar, this.message, this.time});

  Messlist.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    message = json['message'];
    time = json['time'];
    messNum = json['messNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['message'] = this.message;
    data['time'] = this.time;
    data['messNum'] = this.messNum;
    return data;
  }
}

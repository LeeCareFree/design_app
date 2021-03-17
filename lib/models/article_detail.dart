class ArticleDetail {
  Data data;
  String msg;
  int code;

  ArticleDetail({this.data, this.msg, this.code});

  ArticleDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  List<String> imgList;
  String type;
  String aid;
  String title;
  String detail;
  int like;
  int coll;
  User user;
  List<Comments> comments;

  Data(
      {this.imgList,
      this.type,
      this.aid,
      this.title,
      this.detail,
      this.like,
      this.coll,
      this.user,
      this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    imgList = json['imgList'].cast<String>();
    type = json['type'];
    aid = json['aid'];
    title = json['title'];
    detail = json['detail'];
    like = json['like'];
    coll = json['coll'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgList'] = this.imgList;
    data['type'] = this.type;
    data['aid'] = this.aid;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['like'] = this.like;
    data['coll'] = this.coll;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String username;
  String nickname;
  String avatar;
  String uid;

  User({this.username, this.nickname, this.avatar, this.uid});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['uid'] = this.uid;
    return data;
  }
}

class Comments {
  String uid;
  String cid;
  String content;
  User user;

  Comments({this.uid, this.cid, this.content, this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    cid = json['cid'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['cid'] = this.cid;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

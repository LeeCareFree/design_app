class DecorateArticle {
  List<Desc> desc;
  String type;
  String aid;
  String title;
  int like;
  int coll;
  String createtime;
  String cover;
  String doorModel;
  String area;
  String cost;
  String location;
  String duplex;
  String decoratestyle;
  String decorateduration;
  String decorateother;
  User user;
  List<Comments> comments;

  DecorateArticle(
      {this.desc,
      this.type,
      this.aid,
      this.title,
      this.like,
      this.coll,
      this.createtime,
      this.cover,
      this.doorModel,
      this.area,
      this.cost,
      this.location,
      this.duplex,
      this.decoratestyle,
      this.decorateduration,
      this.decorateother,
      this.user,
      this.comments});

  DecorateArticle.fromJson(Map<String, dynamic> json) {
    if (json['desc'] != null) {
      desc = new List<Desc>();
      json['desc'].forEach((v) {
        desc.add(new Desc.fromJson(v));
      });
    }
    type = json['type'];
    aid = json['aid'];
    title = json['title'];
    like = json['like'];
    coll = json['coll'];
    createtime = json['createtime'];
    cover = json['cover'];
    doorModel = json['doorModel'];
    area = json['area'];
    cost = json['cost'];
    location = json['location'];
    duplex = json['duplex'];
    decoratestyle = json['decoratestyle'];
    decorateduration = json['decorateduration'];
    decorateother = json['decorateother'];
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
    if (this.desc != null) {
      data['desc'] = this.desc.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['aid'] = this.aid;
    data['title'] = this.title;
    data['like'] = this.like;
    data['coll'] = this.coll;
    data['createtime'] = this.createtime;
    data['cover'] = this.cover;
    data['doorModel'] = this.doorModel;
    data['area'] = this.area;
    data['cost'] = this.cost;
    data['location'] = this.location;
    data['duplex'] = this.duplex;
    data['decoratestyle'] = this.decoratestyle;
    data['decorateduration'] = this.decorateduration;
    data['decorateother'] = this.decorateother;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String title;
  String content;
  List<String> imgList;

  Desc({this.title, this.content, this.imgList});

  Desc.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    imgList = json['imgList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['imgList'] = this.imgList;
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
  String cid;
  String uid;
  String content;
  User user;

  Comments({this.cid, this.uid, this.content, this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    uid = json['uid'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['uid'] = this.uid;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

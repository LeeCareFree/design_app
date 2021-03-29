class ArticleInfo {
  List<Desc> _desc;
  String _type;
  String _aid;
  String _title;
  int _like;
  int _coll;
  String _createtime;
  String _cover;
  String _doorModel;
  String _area;
  String _cost;
  String _location;
  String _duplex;
  String _decoratestyle;
  String _decorateduration;
  String _decorateother;
  String _detail;
  List<String> _imgList;
  User _user;
  List<Comments> _comments;

  ArticleInfo(
      {List<Desc> desc,
      String type,
      String aid,
      String title,
      int like,
      int coll,
      String createtime,
      String cover,
      String doorModel,
      String area,
      String cost,
      String location,
      String duplex,
      String decoratestyle,
      String decorateduration,
      String decorateother,
      String detail,
      List<String> imgList,
      User user,
      List<Comments> comments}) {
    this._desc = desc;
    this._type = type;
    this._aid = aid;
    this._title = title;
    this._like = like;
    this._coll = coll;
    this._createtime = createtime;
    this._cover = cover;
    this._doorModel = doorModel;
    this._area = area;
    this._cost = cost;
    this._location = location;
    this._duplex = duplex;
    this._decoratestyle = decoratestyle;
    this._decorateduration = decorateduration;
    this._decorateother = decorateother;
    this._detail = detail;
    this._imgList = imgList;
    this._user = user;
    this._comments = comments;
  }

  List<Desc> get desc => _desc;
  set desc(List<Desc> desc) => _desc = desc;
  String get type => _type;
  set type(String type) => _type = type;
  String get aid => _aid;
  set aid(String aid) => _aid = aid;
  String get title => _title;
  set title(String title) => _title = title;
  int get like => _like;
  set like(int like) => _like = like;
  int get coll => _coll;
  set coll(int coll) => _coll = coll;
  String get createtime => _createtime;
  set createtime(String createtime) => _createtime = createtime;
  String get cover => _cover;
  set cover(String cover) => _cover = cover;
  String get doorModel => _doorModel;
  set doorModel(String doorModel) => _doorModel = doorModel;
  String get area => _area;
  set area(String area) => _area = area;
  String get cost => _cost;
  set cost(String cost) => _cost = cost;
  String get location => _location;
  set location(String location) => _location = location;
  String get duplex => _duplex;
  set duplex(String duplex) => _duplex = duplex;
  String get decoratestyle => _decoratestyle;
  set decoratestyle(String decoratestyle) => _decoratestyle = decoratestyle;
  String get decorateduration => _decorateduration;
  set decorateduration(String decorateduration) =>
      _decorateduration = decorateduration;
  String get decorateother => _decorateother;
  set decorateother(String decorateother) => _decorateother = decorateother;
  String get detail => _detail;
  set detail(String detail) => _detail = detail;
  List<String> get imgList => _imgList;
  set imgList(List<String> imgList) => _imgList = imgList;
  User get user => _user;
  set user(User user) => _user = user;
  List<Comments> get comments => _comments;
  set comments(List<Comments> comments) => _comments = comments;

  ArticleInfo.fromJson(Map<String, dynamic> json) {
    if (json['desc'] != null) {
      _desc = new List<Desc>();
      json['desc'].forEach((v) {
        _desc.add(new Desc.fromJson(v));
      });
    }
    _type = json['type'];
    _aid = json['aid'];
    _title = json['title'];
    _like = json['like'];
    _coll = json['coll'];
    _createtime = json['createtime'];
    _cover = json['cover'];
    _doorModel = json['doorModel'];
    _area = json['area'];
    _cost = json['cost'];
    _location = json['location'];
    _duplex = json['duplex'];
    _decoratestyle = json['decoratestyle'];
    _decorateduration = json['decorateduration'];
    _decorateother = json['decorateother'];
    _detail = json['detail'];
    _imgList = json['imgList'].cast<String>();
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      _comments = new List<Comments>();
      json['comments'].forEach((v) {
        _comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._desc != null) {
      data['desc'] = this._desc.map((v) => v.toJson()).toList();
    }
    data['type'] = this._type;
    data['aid'] = this._aid;
    data['title'] = this._title;
    data['like'] = this._like;
    data['coll'] = this._coll;
    data['createtime'] = this._createtime;
    data['cover'] = this._cover;
    data['doorModel'] = this._doorModel;
    data['area'] = this._area;
    data['cost'] = this._cost;
    data['location'] = this._location;
    data['duplex'] = this._duplex;
    data['decoratestyle'] = this._decoratestyle;
    data['decorateduration'] = this._decorateduration;
    data['decorateother'] = this._decorateother;
    data['detail'] = this._detail;
    data['imgList'] = this._imgList;
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    if (this._comments != null) {
      data['comments'] = this._comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String _title;
  String _content;
  List<String> _imgList;

  Desc({String title, String content, List<String> imgList}) {
    this._title = title;
    this._content = content;
    this._imgList = imgList;
  }

  String get title => _title;
  set title(String title) => _title = title;
  String get content => _content;
  set content(String content) => _content = content;
  List<String> get imgList => _imgList;
  set imgList(List<String> imgList) => _imgList = imgList;

  Desc.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _content = json['content'];
    _imgList = json['imgList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['content'] = this._content;
    data['imgList'] = this._imgList;
    return data;
  }
}

class User {
  String _username;
  String _nickname;
  String _avatar;
  String _uid;

  User({String username, String nickname, String avatar, String uid}) {
    this._username = username;
    this._nickname = nickname;
    this._avatar = avatar;
    this._uid = uid;
  }

  String get username => _username;
  set username(String username) => _username = username;
  String get nickname => _nickname;
  set nickname(String nickname) => _nickname = nickname;
  String get avatar => _avatar;
  set avatar(String avatar) => _avatar = avatar;
  String get uid => _uid;
  set uid(String uid) => _uid = uid;

  User.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _nickname = json['nickname'];
    _avatar = json['avatar'];
    _uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['nickname'] = this._nickname;
    data['avatar'] = this._avatar;
    data['uid'] = this._uid;
    return data;
  }
}

class Comments {
  String _cid;
  String _uid;
  String _content;
  User _user;

  Comments({String cid, String uid, String content, User user}) {
    this._cid = cid;
    this._uid = uid;
    this._content = content;
    this._user = user;
  }

  String get cid => _cid;
  set cid(String cid) => _cid = cid;
  String get uid => _uid;
  set uid(String uid) => _uid = uid;
  String get content => _content;
  set content(String content) => _content = content;
  User get user => _user;
  set user(User user) => _user = user;

  Comments.fromJson(Map<String, dynamic> json) {
    _cid = json['cid'];
    _uid = json['uid'];
    _content = json['content'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this._cid;
    data['uid'] = this._uid;
    data['content'] = this._content;
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }
}

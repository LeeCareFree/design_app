/*
 * @Author: your name
 * @Date: 2021-03-18 14:20:40
 * @LastEditTime: 2021-03-18 14:25:09
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\models\article_list_data.dart
 */
class ArticleListData {
  List<String> imgList;
  String type;
  String aid;
  String title;
  String detail;
  String cover;
  int like;
  int coll;
  String createtime;
  User user;

  ArticleListData(
      {this.imgList,
      this.type,
      this.aid,
      this.title,
      this.detail,
      this.cover,
      this.like,
      this.coll,
      this.createtime,
      this.user});

  ArticleListData.fromJson(Map<String, dynamic> json) {
    imgList = json['imgList'].cast<String>();
    type = json['type'];
    aid = json['aid'];
    title = json['title'];
    detail = json['detail'];
    cover = json['cover'];
    like = json['like'];
    coll = json['coll'];
    createtime = json['createtime'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgList'] = this.imgList;
    data['type'] = this.type;
    data['aid'] = this.aid;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['cover'] = this.cover;
    data['like'] = this.like;
    data['coll'] = this.coll;
    data['createtime'] = this.createtime;
    if (this.user != null) {
      data['user'] = this.user.toJson();
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
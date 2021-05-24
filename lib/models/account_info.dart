class AccountInfo {
  String uid;
  String username;
  String nickname;
  String avatar;
  String bgimg;
  String introduction;
  String city;
  int gender;
  int proNum;
  int likeNum;
  int collNum;
  int fansNum;
  int followNum;
  int likeColl;
  String identity;

  AccountInfo(
      {this.uid,
      this.username,
      this.nickname,
      this.avatar,
      this.bgimg,
      this.proNum,
      this.likeNum,
      this.collNum,
      this.fansNum,
      this.followNum,
      this.likeColl,
      this.introduction,
      this.gender,
      this.city,
      this.identity});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    bgimg = json['bgimg'];
    proNum = json['proNum'];
    likeNum = json['likeNum'];
    collNum = json['collNum'];
    fansNum = json['fansNum'];
    followNum = json['followNum'];
    likeColl = json['like_coll'];
    introduction = json['introduction'];
    gender = json['gender'];
    city = json['city'];
    identity = json['identity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['bgimg'] = this.bgimg;
    data['proNum'] = this.proNum;
    data['likeNum'] = this.likeNum;
    data['collNum'] = this.collNum;
    data['fansNum'] = this.fansNum;
    data['followNum'] = this.followNum;
    data['like_coll'] = this.likeColl;
    data['introduction'] = this.introduction;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['identity'] = this.identity;
    return data;
  }
}

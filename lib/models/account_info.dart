class AccountInfo {
  String uid;
  String username;
  String nickname;
  String avatar;
  int proNum;
  int likeNum;
  int collNum;
  int fansNum;
  int followNum;

  AccountInfo(
      {this.uid,
      this.username,
      this.nickname,
      this.avatar,
      this.proNum,
      this.likeNum,
      this.collNum,
      this.fansNum,
      this.followNum});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    proNum = json['proNum'];
    likeNum = json['likeNum'];
    collNum = json['collNum'];
    fansNum = json['fansNum'];
    followNum = json['followNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['proNum'] = this.proNum;
    data['likeNum'] = this.likeNum;
    data['collNum'] = this.collNum;
    data['fansNum'] = this.fansNum;
    data['followNum'] = this.followNum;
    return data;
  }
}

class DesignerList {
  List<Result> result;

  DesignerList({this.result});

  DesignerList.fromJson(Map<String, dynamic> json) {
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
  String identity;
  List<String> proArr;
  String username;
  String nickname;
  String avatar;
  String bgimg;
  String uid;
  DetailInfo detailInfo;
  List<String> prodImgList;

  Result(
      {this.identity,
      this.proArr,
      this.username,
      this.nickname,
      this.avatar,
      this.bgimg,
      this.uid,
      this.detailInfo,
      this.prodImgList});

  Result.fromJson(Map<String, dynamic> json) {
    identity = json['identity'];
    proArr = json['proArr'].cast<String>();
    username = json['username'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    bgimg = json['bgimg'];
    uid = json['uid'];
    detailInfo = json['detailInfo'] != null
        ? new DetailInfo.fromJson(json['detailInfo'])
        : null;
    prodImgList = json['prodImgList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identity'] = this.identity;
    data['proArr'] = this.proArr;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['bgimg'] = this.bgimg;
    data['uid'] = this.uid;
    if (this.detailInfo != null) {
      data['detailInfo'] = this.detailInfo.toJson();
    }
    data['prodImgList'] = this.prodImgList;
    return data;
  }
}

class DetailInfo {
  String address;
  String city;
  int designfee;
  List<String> stylearr;
  String styletype;

  DetailInfo(
      {this.address, this.city, this.designfee, this.stylearr, this.styletype});

  DetailInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    designfee = json['designfee'];
    stylearr = json['stylearr'].cast<String>();
    styletype = json['styletype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['designfee'] = this.designfee;
    data['stylearr'] = this.stylearr;
    data['styletype'] = this.styletype;
    return data;
  }
}

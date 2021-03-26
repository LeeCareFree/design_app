class SearchArticleModel {
  List<SearchArticle> data;
  String msg;
  int code;

  SearchArticleModel({this.data, this.msg, this.code});

  SearchArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SearchArticle>();
      json['data'].forEach((v) {
        data.add(new SearchArticle.fromJson(v));
      });
    }
    msg = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['code'] = this.code;
    return data;
  }
}

class SearchArticle {
  List<String> imgList;
  String sId;
  String type;
  String title;
  String aid;
  String detail;

  SearchArticle({this.imgList, this.sId, this.type, this.title, this.detail, this.aid});

  SearchArticle.fromJson(Map<String, dynamic> json) {
    imgList = json['imgList'].cast<String>();
    sId = json['_id'];
    type = json['type'];
    title = json['title'];
    detail = json['detail'];
    aid = json['aid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgList'] = this.imgList;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['aid'] = this.aid;
    return data;
  }
}
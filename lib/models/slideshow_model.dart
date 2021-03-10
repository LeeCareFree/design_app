class SlideShow {
  List<Data> data;
  String msg;
  int code;

  SlideShow({this.data, this.msg, this.code});

  SlideShow.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  List<String> imgList;
  String title;

  Data({this.imgList, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    imgList = json['imgList'].cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgList'] = this.imgList;
    data['title'] = this.title;
    return data;
  }
}
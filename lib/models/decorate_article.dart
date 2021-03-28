class DecorateArticle {
  String type;
  String aid;
  String uid;
  String title;
  int like;
  int coll;
  String createtime;
  String doorModel;
  String area;
  String cost;
  String location;
  String duplex;
  List<Desc> desc;
  List<Require> require;

  DecorateArticle(
      {this.type,
      this.aid,
      this.uid,
      this.title,
      this.like,
      this.coll,
      this.createtime,
      this.doorModel,
      this.area,
      this.cost,
      this.location,
      this.duplex,
      this.desc,
      this.require});

  DecorateArticle.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    aid = json['aid'];
    uid = json['uid'];
    title = json['title'];
    like = json['like'];
    coll = json['coll'];
    createtime = json['createtime'];
    doorModel = json['doorModel'];
    area = json['area'];
    cost = json['cost'];
    location = json['location'];
    duplex = json['duplex'];
    if (json['desc'] != null) {
      desc = new List<Desc>();
      json['desc'].forEach((v) {
        desc.add(new Desc.fromJson(v));
      });
    }
    if (json['require'] != null) {
      require = new List<Require>();
      json['require'].forEach((v) {
        require.add(new Require.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['aid'] = this.aid;
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['like'] = this.like;
    data['coll'] = this.coll;
    data['createtime'] = this.createtime;
    data['doorModel'] = this.doorModel;
    data['area'] = this.area;
    data['cost'] = this.cost;
    data['location'] = this.location;
    data['duplex'] = this.duplex;
    if (this.desc != null) {
      data['desc'] = this.desc.map((v) => v.toJson()).toList();
    }
    if (this.require != null) {
      data['require'] = this.require.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String floorplan;
  List<String> imgList;
  String drawingroom;
  String kitchen;
  String masterbedroom;
  String secondarybedroom;
  String toilet;
  String study;
  String balcony;
  String corridor;

  Desc(
      {this.floorplan,
      this.imgList,
      this.drawingroom,
      this.kitchen,
      this.masterbedroom,
      this.secondarybedroom,
      this.toilet,
      this.study,
      this.balcony,
      this.corridor});

  Desc.fromJson(Map<String, dynamic> json) {
    floorplan = json['floorplan'];
    imgList = json['imgList'].cast<String>();
    drawingroom = json['drawingroom'];
    kitchen = json['kitchen'];
    masterbedroom = json['masterbedroom'];
    secondarybedroom = json['secondarybedroom'];
    toilet = json['toilet'];
    study = json['study'];
    balcony = json['balcony'];
    corridor = json['corridor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floorplan'] = this.floorplan;
    data['imgList'] = this.imgList;
    data['drawingroom'] = this.drawingroom;
    data['kitchen'] = this.kitchen;
    data['masterbedroom'] = this.masterbedroom;
    data['secondarybedroom'] = this.secondarybedroom;
    data['toilet'] = this.toilet;
    data['study'] = this.study;
    data['balcony'] = this.balcony;
    data['corridor'] = this.corridor;
    return data;
  }
}

class Require {
  String style;
  String period;
  String other;

  Require({this.style, this.period, this.other});

  Require.fromJson(Map<String, dynamic> json) {
    style = json['style'];
    period = json['period'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['style'] = this.style;
    data['period'] = this.period;
    data['other'] = this.other;
    return data;
  }
}

class MyhomeInfo {
  String uid;
  String area;
  String beginTime;
  String checkInTime;
  String city;
  String cost;
  String doorModel;
  String populace;
  String progress;

  MyhomeInfo(
      {this.uid,
      this.area,
      this.beginTime,
      this.checkInTime,
      this.city,
      this.cost,
      this.doorModel,
      this.populace,
      this.progress});

  MyhomeInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    area = json['area'];
    beginTime = json['beginTime'];
    checkInTime = json['checkInTime'];
    city = json['city'];
    cost = json['cost'];
    doorModel = json['doorModel'];
    populace = json['populace'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['area'] = this.area;
    data['beginTime'] = this.beginTime;
    data['checkInTime'] = this.checkInTime;
    data['city'] = this.city;
    data['cost'] = this.cost;
    data['doorModel'] = this.doorModel;
    data['populace'] = this.populace;
    data['progress'] = this.progress;
    return data;
  }
}

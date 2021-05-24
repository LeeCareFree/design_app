class DesignerInfo {
  List<String> stylearr;
  List<String> service;
  String sId;
  String uid;
  String address;
  String city;
  int designfee;

  DesignerInfo(
      {this.stylearr,
      this.service,
      this.sId,
      this.uid,
      this.address,
      this.city,
      this.designfee});

  DesignerInfo.fromJson(Map<String, dynamic> json) {
    stylearr = json['stylearr'].cast<String>();
    service = json['service'].cast<String>();
    sId = json['_id'];
    uid = json['uid'];
    address = json['address'];
    city = json['city'];
    designfee = json['designfee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stylearr'] = this.stylearr;
    data['service'] = this.service;
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['address'] = this.address;
    data['city'] = this.city;
    data['designfee'] = this.designfee;
    return data;
  }
}

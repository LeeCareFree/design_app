class FilterData {
  static List<Map<String, dynamic>> sort = [
    {'key': '-1', 'value': '默认', 'title': '排序'},
    {'key': '{inputTime} desc', 'value': '最新发布', 'title': '最新发布'},
    {'key': '{look} desc', 'value': '带看最多', 'title': '带看最多'},
    {'key': '{latestFollow} desc', 'value': '最新跟进', 'title': '最新跟进'},
    {'key': '{price} desc', 'value': '价格从高到低', 'title': '价格从高到低'},
    {'key': '{price} asc', 'value': '价格从低到高', 'title': '价格从低到高'},
    {'key': '{area} desc', 'value': '面积从高到低', 'title': '面积从高到低'},
    {'key': '{area} asc', 'value': '面积从低到高', 'title': '面积从低到高'},
  ];
  static List<Map<String, dynamic>> services = [
    {'key': '-1', 'value': '不限', 'title': '不限'},
    {'key': '0', 'value': '全屋设计', 'title': '全屋设计'},
    {'key': '1', 'value': '硬装设计', 'title': '硬装设计'},
    {'key': '2', 'value': '软装设计', 'title': '软装设计'},
  ];
  static List<Map<String, dynamic>> styles = [
    {'key': '-1', 'value': '不限', 'title': '不限'},
    {'key': '0', 'value': '现代简约风', 'title': '现代简约风'},
    {'key': '1', 'value': '北欧风', 'title': '北欧风'},
    {'key': '2', 'value': '清新田园风', 'title': '清新田园风'},
    {'key': '3', 'value': '后现代风', 'title': '后现代风'},
    {'key': '4', 'value': '美式风', 'title': '美式风'},
    {'key': '5', 'value': '新中式风', 'title': '新中式风'},
    {'key': '6', 'value': '欧式古典风', 'title': '欧式古典风'},
    {'key': '7', 'value': '神秘地中海风', 'title': '神秘地中海风'},
    {'key': '8', 'value': '东南亚风', 'title': '东南亚风'},
    {'key': '9', 'value': '日式和风', 'title': '日式和风'},
  ];

  static List<Map<String, dynamic>> housingTypes = [
    {'key': '-1', 'value': '不限'},
    {'key': '000', 'value': '出售'},
    {'key': '1111', 'value': '出租'},
  ];
  static List<Map<String, dynamic>> amount = [
    {'key': '-1', 'value': '不限'},
    {'key': '99>', 'value': '99元/㎡以下'},
    {'key': '99> 199', 'value': '99元/㎡-199元/㎡'},
    {'key': '199> 299', 'value': '199元/㎡-299元/㎡'},
    {'key': '299> 399', 'value': '299元/㎡-399元/㎡'},
    {'key': '399> 499', 'value': '399元/㎡-499元/㎡'},
    {'key': '>499 ', 'value': '499元/㎡以上'},
  ];

  static List<Map<String, Object>> moreListMap = [
    {'key': '-1', 'value': '不限'},
    {'key': 11725, 'value': '一般'},
    {'key': 11726, 'value': '紧迫'},
    {'key': 11727, 'value': '非常紧迫'},
  ];
}

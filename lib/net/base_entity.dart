/*
 * @Author: your name
 * @Date: 2020-10-14 10:59:53
 * @LastEditTime: 2020-11-13 10:16:51
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\net\base_entity.dart
 */
import 'package:bluespace/models/entity_factory.dart';
import 'package:bluespace/utils/common.dart';


class BaseEntity<T>{

  int code;
  String msg;
  T data;
  List<T> listData = [];

  BaseEntity(this.code, this.msg, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    msg = json[Constant.msg];
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item) {
          listData.add(_generateOBJ<T>(item));
        });
      } else {
        data = _generateOBJ(json[Constant.data]);
      }
    }
  }

  S _generateOBJ<S>(json) {
    if (S.toString() == "String") {
      return json.toString() as S;
    } else if (T.toString() == "Map<dynamic, dynamic>") {
      return json as S;
    } else {
      return EntityFactory.generateOBJ(json);
    }
  }
}
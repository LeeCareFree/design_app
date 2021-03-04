/*
 * @Author: your name
 * @Date: 2020-10-10 18:34:50
 * @LastEditTime: 2020-10-10 18:38:20
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\models\entity_factory.dart
 */
import 'package:bluespace/models/login_model.dart';
import 'package:bluespace/models/user_info.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == "LoginModel") {
      return LoginModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}

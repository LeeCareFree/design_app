/*
 * @Author: your name
 * @Date: 2020-10-13 19:04:36
 * @LastEditTime: 2020-10-13 19:04:57
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\entity\entity_factory.dart
 */
import 'film_entity.dart';
class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "FilmEntity") {
      return FilmEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
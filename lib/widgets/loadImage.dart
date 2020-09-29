/*
 * @Author: your name
 * @Date: 2020-09-29 17:21:25
 * @LastEditTime: 2020-09-29 18:00:34
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \my_flutter_app\lib\widgets\loadImage.dart
 */
import 'package:bule_space/utils/imageUtil.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 加载图片类
class LoadImage extends StatelessWidget{
  const LoadImage(this.image,{
    Key key,
    this.width,
    this.height,
    this.fit: BoxFit.cover,
    this.format: "png",
    this.holderImg: "none"
  }): super(key: key);
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(TextUtil.isEmpty(image) || image =="null"){
      return LoadAssetImage(
        holderImg,
        height: height,
        width: width,
        fit: fit,
        format: format
      );
    }else{
      if(image.startsWith("http")){
        return CachedNetworkImage(imageUrl: image,
        placeholder: (context, url) => LoadAssetImage(holderImg,height: height,width: width,fit: fit,format: format),
        errorWidget: (context, url, error) => LoadAssetImage(holderImg, height: height, width: width, fit: fit),width: width,height: height,fit: fit,);
      }else{
        return LoadAssetImage(image,height: height,width: width,fit: fit,format: format);
      }
    }
  }
}
// 加载本地asset图片类
class LoadAssetImage extends StatelessWidget{
  const LoadAssetImage(this.image,{
    Key key,
    this.width,
    this.height, 
    this.fit,
    this.format: 'png',
    this.color
  }): super(key:key);
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final Color color;
  @override
  Widget build(BuildContext context) {

    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
      color: color,
    );
  }
}
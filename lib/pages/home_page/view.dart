import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  if (state.bannerList.length == 0) {
    dispatch(HomeActionCreator.getBanner());
  }

  return Scaffold(
    backgroundColor: Colors.red,
    body: Column(
      
      children: [
        Container(
          // color: Colors.red,
          margin: EdgeInsets.only(top: Adapt.px(60), bottom: Adapt.px(20)),
          child: state.bannerList.length != 0 ?
            SwiperDiy(swiperDataList: state.bannerList)
            :
            Center(child: Text('加载中')),
        ),
        
      ],
    ),
    
  );
  // return Container();
}


// 轮播图
class SwiperDiy extends StatelessWidget {

  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}): super(key:key);
  
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).padding.top);
    return Container(
      width: Adapt.px(750),
      height: Adapt.px(400),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {

          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Adapt.px(750),
                  height: Adapt.px(80),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                    child: Text("${swiperDataList[index].title}", 
                      style: TextStyle(color: Colors.white),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Adapt.px(10)),
                      bottomRight: Radius.circular(Adapt.px(10))
                    )
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${swiperDataList[index].imgList[0]}"),
                fit: BoxFit.fill
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Adapt.px(10))
              )
            ),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 10),
          builder: DotSwiperPaginationBuilder(
            color: Colors.white70,         
            activeColor: Colors.redAccent,
          )
        ),
        autoplay: true,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}

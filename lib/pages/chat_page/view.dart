import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ChatState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          '消息',
          style: TextStyle(color: Colors.black, fontSize: Adapt.sp(32)),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        slivers: [_ChatList(chatList: state.chatList)],
      ));
}

class _ChatList extends StatelessWidget {
  final ChatList chatList;
  const _ChatList({this.chatList});
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: Adapt.height(120),
      delegate: SliverChildBuilderDelegate(
          (_, int index) => InkWell(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: Adapt.width(30)),
                width: Adapt.screenW(),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(chatList.result[index]?.avatar),
                        radius: Adapt.width(50),
                      ),
                    ),
                    Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            SizedBox(width: Adapt.width(20)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(chatList.result[index]?.nickname),
                                SizedBox(
                                  height: Adapt.height(10),
                                ),
                                Text(chatList.result[index]?.lastMessage)
                              ],
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, Adapt.height(30), Adapt.width(30), 0),
                          alignment: Alignment.topRight,
                          child: Text(chatList.result[index]?.lastTime),
                        ))
                  ],
                ),
              )),
          childCount: chatList?.result?.length),
    );
  }
}

import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ChatState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          '消息',
          style: TextStyle(color: Colors.black, fontSize: Adapt.sp(36)),
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
              onTap: () => Navigator.of(context).pushNamed('chatDetailPage'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.width(30)),
                width: Adapt.screenW(),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                                Text(
                                  chatList.result[index]?.nickname,
                                  style: TextStyle(fontSize: Adapt.sp(32)),
                                ),
                                SizedBox(
                                  height: Adapt.height(10),
                                ),
                                Text(
                                  chatList.result[index]?.lastMessage,
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, Adapt.height(20), Adapt.width(20), 0),
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

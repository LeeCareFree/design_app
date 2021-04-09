import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
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
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: Adapt.height(20),
            ),
          ),
          _ChatList(messageList: state.messageList ?? <Widget>[])
        ],
      ));
}

class _ChatList extends StatelessWidget {
  final MessageList messageList;
  const _ChatList({this.messageList});
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: Adapt.height(120),
      delegate: SliverChildBuilderDelegate(
          (_, int index) => InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed('chatDetailPage', arguments: {
                    "guid": messageList.messlist[index]?.uid,
                    "avatar": messageList.messlist[index]?.avatar,
                    "nickname": messageList.messlist[index]?.nickname
                  }),
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
                            NetworkImage(messageList.messlist[index]?.avatar),
                        radius: Adapt.width(50),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Row(
                          children: [
                            SizedBox(width: Adapt.width(20)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messageList.messlist[index]?.nickname,
                                  style: TextStyle(fontSize: Adapt.sp(32)),
                                ),
                                SizedBox(
                                  height: Adapt.height(10),
                                ),
                                Text(
                                  messageList.messlist[index]?.message,
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, Adapt.height(20), Adapt.width(20), 0),
                          alignment: Alignment.topRight,
                          child: Text(
                            messageList.messlist[index]?.time,
                            style: TextStyle(
                                color: Colors.grey, fontSize: Adapt.sp(26)),
                          ),
                        ))
                  ],
                ),
              )),
          childCount: messageList?.messlist?.length),
    );
  }
}

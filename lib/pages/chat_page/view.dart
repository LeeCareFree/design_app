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
          _ChatList(
              messageList: state.messageList != null
                  ? state.messageList
                  : MessageList(messlist: []))
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
                padding: EdgeInsets.symmetric(horizontal: Adapt.width(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: Adapt.width(20)),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                messageList.messlist[index]?.avatar),
                            radius: Adapt.width(50),
                          ),
                        )),
                    Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // direction: Axis.vertical,
                          children: [
                            Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  messageList.messlist[index]?.nickname,
                                  style: TextStyle(fontSize: Adapt.sp(32)),
                                ),
                                Text(
                                  messageList.messlist[index]?.time,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: Adapt.sp(26)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Adapt.height(15),
                            ),
                            Row(children: [
                              Container(
                                  width: Adapt.width(580),
                                  child: Text(
                                    messageList.messlist[index]?.message,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Adapt.sp(28)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                            ])
                          ],
                        )),
                    // Expanded(
                    //     flex: 3,
                    //     child: Container(
                    //       padding: EdgeInsets.fromLTRB(
                    //           0, Adapt.height(20), Adapt.width(20), 0),
                    //       alignment: Alignment.topRight,
                    //       child:
                    //     ))
                  ],
                ),
              )),
          childCount: messageList?.messlist?.length),
    );
  }
}

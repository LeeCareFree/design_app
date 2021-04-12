import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      body: Container(
          margin: EdgeInsets.symmetric(vertical: Adapt.height(20)),
          child: SmartRefresher(
              enablePullDown: true,
              controller: state.refreshController,
              onRefresh: () => {
                    dispatch(ChatActionCreator.refreshPage()),
                  },
              child: ListView(
                scrollDirection: Axis.vertical,
                reverse: false,
                children: state.messageList?.messlist?.length != 0
                    ? state.messageList?.messlist
                        ?.map((e) => _MessageList(
                              messlist: e,
                            ))
                        ?.toList()
                    : [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('暂无消息')],
                        )
                      ],
              ))));
}

class _MessageList extends StatelessWidget {
  final Messlist messlist;
  const _MessageList({this.messlist});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('chatDetailPage',
                  arguments: {
                    "guid": messlist.uid,
                    "avatar": messlist.avatar,
                    "nickname": messlist.nickname
                  }),
          child: Container(
            padding: EdgeInsets.all(Adapt.height(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey[200]))),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(children: [
                      Container(
                        margin: EdgeInsets.only(right: Adapt.width(20)),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(messlist.avatar),
                          radius: Adapt.width(50),
                        ),
                      ),
                      messlist.messNum != null
                          ? Container(
                              margin: EdgeInsets.only(left: Adapt.height(60)),
                              padding: EdgeInsets.all(Adapt.width(10)),
                              // width: Adapt.width(30),
                              // height: Adapt.height(30),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Text(
                                messlist.messNum.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Adapt.sp(24)),
                              ),
                            )
                          : Container(),
                    ])),
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
                              messlist.nickname,
                              style: TextStyle(fontSize: Adapt.sp(32)),
                            ),
                            Text(
                              messlist.time,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: Adapt.sp(26)),
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
                                messlist.message,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: Adapt.sp(28)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
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
    );
  }
}

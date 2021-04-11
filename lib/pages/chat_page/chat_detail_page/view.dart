import 'dart:async';

import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/router/PopRouter.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ChatDetailState state, Dispatch dispatch, ViewService viewService) {
  Timer(
      Duration(milliseconds: 300),
      () => state.scrollController
          .jumpTo(state.scrollController.position.maxScrollExtent));
  final _theme = ThemeStyle.getTheme(viewService.context);
  return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: _theme.iconTheme,
          elevation: 3.0,
          backgroundColor: _theme.bottomAppBarColor,
          brightness: _theme.brightness,
          title: Container(
              width: Adapt.screenW(),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(right: Adapt.width(20)),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(state.avatar ?? ''),
                          radius: Adapt.width(50),
                        ),
                      )),
                  Expanded(
                      flex: 7,
                      child: Text(
                        state.nickname ?? '',
                        style: TextStyle(
                            fontSize: Adapt.sp(32),
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              )),
          actions: [
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () => {})
          ],
        ),
        // bottomNavigationBar:
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                Flexible(
                  child: state.socket?.id == ''
                      ? Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black)))
                      : ListView(
                          scrollDirection: Axis.vertical,
                          controller: state.scrollController,
                          physics: BouncingScrollPhysics(),
                          reverse: false,
                          padding: EdgeInsets.all(Adapt.width(20)),
                          children: state.chatList?.detaillist != null
                              ? state.chatList?.detaillist
                                  ?.map((e) => _MessageItem(
                                      isMe: e.uid == state.uid, detaillist: e))
                                  ?.toList()
                              : <Widget>[],
                        ),
                ),

                // Input content
                Container(
                  child: Row(
                    children: <Widget>[
                      // Button send image
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.image_outlined),
                          // onPressed: getImage,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.keyboard_voice_outlined),
                          onPressed: () => {},
                          color: Colors.grey,
                        ),
                      ),

                      // Edit text
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(Adapt.height(15)),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Adapt.radius(30)),
                              border: Border.all(color: Colors.grey[200])),
                          child: TextField(
                            focusNode: state.focusNode,
                            onSubmitted: (value) {
                              // onSendMessage(textEditingController.text, 0);
                            },
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                            controller: state.textEditingController,
                            decoration: InputDecoration.collapsed(
                              hintText: '发个消息吧...',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            // focusNode: focusNode,
                          ),
                        ),
                      ),
                      // Button send message
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () =>
                              dispatch(ChatDetailActionCreator.sendMessage()),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.grey[200], width: 0.5)),
                      color: Colors.white),
                )
              ],
            ),

            // Loading
          ],
        ),
      ),
      onWillPop: () {
        // socket离开chat
        state.socket.emit("leaveChat", {
          "uid": state.uid,
        });
        // 更新消息列表
        state.socket.emit('messageList', state.uid);
        state.socket.on(
            'getMessageList',
            (data) => {
                  print(data),
                  GlobalStore.store.dispatch(
                      GlobalActionCreator.updateMessageList(
                          MessageList.fromJson(data)))
                });
        return Future.value(true);
      });
}

class _MessageItem extends StatelessWidget {
  final bool isMe;
  final Detaillist detaillist;
  const _MessageItem({this.detaillist, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: Adapt.width(20)),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isMe
                ? Container(
                    constraints:
                        BoxConstraints(maxWidth: Adapt.screenW() / 1.6),
                    padding: EdgeInsets.all(Adapt.width(20)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.radius(30)),
                        color: Colors.blueGrey),
                    child: Text(
                      (detaillist.message).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(detaillist.avatar ?? ''),
                  ),
            SizedBox(width: Adapt.width(20)),
            isMe
                ? CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(detaillist.avatar ?? ''),
                  )
                : Container(
                    constraints:
                        BoxConstraints(maxWidth: Adapt.screenW() / 1.6),
                    // margin: EdgeInsets.only(right: Adapt.width(100)),
                    padding: EdgeInsets.all(Adapt.width(20)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.radius(30)),
                        color: Colors.grey[100]),
                    child: Text(
                      (detaillist.message).toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
          ],
        ));
  }
}

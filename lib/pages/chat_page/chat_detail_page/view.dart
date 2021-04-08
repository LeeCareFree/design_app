import 'dart:async';

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
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
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
                      backgroundImage: NetworkImage(
                          'http://8.129.214.128:3001/upload/avatar/avatar_88704c52-3f86-4932-b4a0-af83dbc8e85f_1617779678742_single.jpg'),
                      radius: Adapt.width(50),
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    '李同学',
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
                child:
                    // state.socket?.id == ''
                    //     ? Center(
                    //         child: CircularProgressIndicator(
                    //             valueColor:
                    //                 AlwaysStoppedAnimation<Color>(Colors.black)))
                    //     :
                    Container(
              child: StreamBuilder(
                stream: state.streamSocket.getResponse,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black)));
                  } else {
                    // listMessage.addAll(snapshot.data.documents);
                    return Text(snapshot.data.documents.toString());

                    // ListView.builder(
                    //   padding: EdgeInsets.all(10.0),
                    //   itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
                    //   itemCount: snapshot.data.documents.length,
                    //   reverse: true,
                    //   controller: state.scrollController,
                    // );
                  }
                },
              ),
            )

                // : StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection('messages')
                //         .doc(groupChatId)
                //         .collection(groupChatId)
                //         .orderBy('timestamp', descending: true)
                //         .limit(_limit)
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Center(
                //             child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
                //       } else {
                //         listMessage.addAll(snapshot.data.documents);
                //         return ListView.builder(
                //           padding: EdgeInsets.all(10.0),
                //           itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
                //           itemCount: snapshot.data.documents.length,
                //           reverse: true,
                //           controller: listScrollController,
                //         );
                //       }
                //     },
                // ),
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
                          borderRadius: BorderRadius.circular(Adapt.radius(30)),
                          border: Border.all(color: Colors.grey[200])),
                      child: TextField(
                        focusNode: state.focusNode,
                        onSubmitted: (value) {
                          // onSendMessage(textEditingController.text, 0);
                        },
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
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
                          dispatch(ChatDetailActionCreator.sendMessage('send')),
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

    // Container(
    //     width: double.infinity,
    //     height: 50.0,
    //     decoration: BoxDecoration(
    //         border: Border(top: BorderSide(color: Colors.red, width: 0.5)),
    //         color: Colors.white),
    //     child: Row(children: <Widget>[

    //     ])),
  );
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

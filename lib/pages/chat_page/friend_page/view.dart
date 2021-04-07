import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FriendState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.red,
      elevation: 1,
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Messages',
          ),
          // if (provider.typing.isNotEmpty) ...[
          //   Text(
          //     provider.typing,
          //   ),
          // ]
        ],
      ),
    ),
    body: Container(
      child: Column(
        children: [
          Flexible(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.all(16),
              children: state.messages,
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(),
          ),
          TextButton(
              onPressed: () =>
                  {dispatch(FriendActionCreator.sendMessage('test'))},
              child: Text('发送'))
        ],
      ),
    ),
  );
}

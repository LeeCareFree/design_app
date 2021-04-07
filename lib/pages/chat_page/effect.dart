import 'package:bluespace/models/chat_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ChatState> buildEffect() {
  return combineEffects(<Object, Effect<ChatState>>{
    ChatAction.action: _onAction,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<ChatState> ctx) {}
void _onInit(Action action, Context<ChatState> ctx) {
  ctx.state.chatList = ChatList.fromJson({
    "result": [
      {
        "uid": "lee",
        "avatar":
            "http://8.129.214.128:3001/upload/avatar/avatar_88704c52-3f86-4932-b4a0-af83dbc8e85f_1617779678742_single.jpg",
        "nickname": "李同学",
        "lastTime": "刚刚",
        "lastMessage": "你好呀，李同学！"
      },
      {
        "uid": "lee",
        "avatar":
            "http://8.129.214.128:3001/upload/avatar/avatar_88704c52-3f86-4932-b4a0-af83dbc8e85f_1617779678742_single.jpg",
        "nickname": "李同学",
        "lastTime": "刚刚",
        "lastMessage": "你好呀，李同学！"
      },
      {
        "uid": "lee",
        "avatar":
            "http://8.129.214.128:3001/upload/avatar/avatar_88704c52-3f86-4932-b4a0-af83dbc8e85f_1617779678742_single.jpg",
        "nickname": "李同学",
        "lastTime": "刚刚",
        "lastMessage": "你好呀，李同学！"
      },
      {
        "uid": "lee",
        "avatar":
            "http://8.129.214.128:3001/upload/avatar/avatar_88704c52-3f86-4932-b4a0-af83dbc8e85f_1617779678742_single.jpg",
        "nickname": "李同学",
        "lastTime": "刚刚",
        "lastMessage": "你好呀，李同学！"
      },
      {
        "uid": "lee",
        "avatar": "http://8.129.214.128:3001/avatar/lee.jpg",
        "nickname": "李同学",
        "lastTime": "刚刚",
        "lastMessage": "你好呀，李同学！"
      },
      {
        "uid": "lee",
        "avatar": "http://8.129.214.128:3001/avatar/lee.jpg",
        "nickname": "李同学",
        "lastTime": "刚刚",
        "lastMessage": "你好呀，李同学！"
      },
    ]
  });
}

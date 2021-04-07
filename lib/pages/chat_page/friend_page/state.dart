import 'package:bluespace/components/message_item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class FriendState implements Cloneable<FriendState> {
  IO.Socket socket;
  List<MessageItem> messages = [];
  @override
  FriendState clone() {
    return FriendState()
      ..messages = messages
      ..socket = socket;
  }
}

FriendState initState(Map<String, dynamic> args) {
  return FriendState();
}

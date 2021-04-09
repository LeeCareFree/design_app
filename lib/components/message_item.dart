import 'package:bluespace/models/chat_model.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/utils/timeago.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final bool isMe;
  final ChatModel message;
  const MessageItem({
    Key key,
    this.isMe = false,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Adapt.height(20)),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Row(
              children: [
                isMe
                    ? Container(
                        padding: EdgeInsets.all(Adapt.width(20)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Adapt.radius(30)),
                            color: Colors.blueGrey[200]),
                        child: Text(message.message),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(message.avatar ?? ''),
                      ),
                SizedBox(width: Adapt.width(20)),
                isMe
                    ? CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(message.avatar ?? ''),
                      )
                    : Container(
                        padding: EdgeInsets.all(Adapt.width(20)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Adapt.radius(30)),
                            color: Colors.blueGrey[200]),
                        child: Text(message.message),
                      ),
              ],
            )
          ],
        ));
  }
}

import 'package:bluespace/pages/chat_page/model/chat_model.dart';
import 'package:bluespace/utils/timeago.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isMe ? 'Me' : message?.username ?? '',
          ),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: (isMe ? Colors.white : Colors.black).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    message?.message ?? '',
                  ),
                ),
              ),
            ],
          ),
          Text(
            '${timeAgoSinceDate(message?.timestamp ?? DateTime.now())}',
          ),
        ],
      ),
    );
  }
}

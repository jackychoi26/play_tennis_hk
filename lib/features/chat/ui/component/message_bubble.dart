import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Align(
        alignment: message.senderId == 'currentUserId' ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: message.senderId == 'currentUserId' ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content.map((c) => c.value).join(' ')),
        ),
      ),
    );
  }
}

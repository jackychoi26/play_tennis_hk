import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.senderId == 'currentUserId';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isCurrentUser)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.person,
                  size: 24,
                  color: Colors.grey[600],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.content.map((c) => c.value).join(' '),
                style: TextStyle(color: isCurrentUser ? Colors.black : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

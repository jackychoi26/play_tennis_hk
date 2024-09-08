import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';

class ChatroomScreen extends ConsumerStatefulWidget {
  final String conversationId;

  const ChatroomScreen({Key? key, required this.conversationId}) : super(key: key);

  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends ConsumerState<ChatroomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(chatNotifierProvider.notifier).getMessageHistory(widget.conversationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天室'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return MessageBubble(
                      message: Message(
                        senderId: 'currentUserId',
                        receiverIds: ['receiverId'],
                        role: MessageRole.sender,
                        content: [TextContent('Hello')],
                        messageType: MessageType.text,
                      ),
                    );
                  },
                );
                // final messagesState = ref.watch(chatNotifierProvider);
                // return messagesState.when(
                //   data: (messages) => ListView.builder(
                //     controller: _scrollController,
                //     reverse: true,
                //     itemCount: messages.length,
                //     itemBuilder: (context, index) {
                //       final message = messages[index];
                //       return MessageBubble(message: message);
                //     },
                //   ),
                //   loading: () => const Center(child: CircularProgressIndicator()),
                //   error: (error, stackTrace) => Center(child: Text('錯誤: $error')),
                // );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: '輸入訊息...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final message = Message(
        senderId: 'currentUserId',
        receiverIds: ['receiverId'],
        role: MessageRole.sender,
        content: [TextContent(_messageController.text)],
        messageType: MessageType.text,
      );
      // ref.read(chatNotifierProvider.notifier).sendMessage(message);
      _messageController.clear();
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';
import 'package:play_tennis_hk/features/chat/ui/component/message_bubble.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final String conversationId;

  const ConversationScreen({Key? key, required this.conversationId}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
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
                  itemCount: 1,
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
          Ink(
            color: Colors.grey[200],
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        debugPrint('Add button tapped');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _messageController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: 'please input message...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: _sendMessage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Transform.rotate(
                            angle: -3.14 / 4,
                            child: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

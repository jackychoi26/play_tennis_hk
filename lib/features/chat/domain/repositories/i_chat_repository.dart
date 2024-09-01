import 'package:play_tennis_hk/features/chat/domain/entities/conversation.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';

abstract class IChatRepository {
  Future<void> sendMessage(Message message);
  Stream<Message> receiveMessages(String conversationId);
  Future<void> createConversation(Conversation conversation);
  Future<List<Conversation>> getConversations();
  Future<List<Message>> getMessageHistory(String conversationId);
  Future<void> markMessageAsRead(String messageId);
  Future<void> deleteMessage(String messageId);
  Future<List<Message>> searchMessages(String query);
}

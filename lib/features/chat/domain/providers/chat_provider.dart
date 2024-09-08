import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/conversation.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';
import 'package:play_tennis_hk/features/chat/domain/repositories/i_chat_repository.dart';

class ChatNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  final IChatRepository _repository;

  ChatNotifier(this._repository) : super(const AsyncLoading());

  Future<void> sendMessage(Message message) async {
    await _repository.sendMessage(message);
  }

  Stream<Message> receiveMessages(String conversationId) {
    return _repository.receiveMessages(conversationId);
  }

  Future<void> createConversation(Conversation conversation) async {
    await _repository.createConversation(conversation);
  }

  Future<List<Conversation>> getConversations() async {
    return await _repository.getConversations();
  }

  Future<List<Message>> getMessageHistory(String conversationId) async {
    return await _repository.getMessageHistory(conversationId);
  }

  Future<void> markMessageAsRead(String messageId) async {
    await _repository.markMessageAsRead(messageId);
  }

  Future<void> deleteMessage(String messageId) async {
    await _repository.deleteMessage(messageId);
  }

  Future<List<Message>> searchMessages(String query) async {
    return await _repository.searchMessages(query);
  }
}

// final chatNotifierProvider = StateNotifierProvider<ChatNotifier, AsyncValue<List<Message>>>((ref) {
//   final repository = ref.watch();
//   return ChatNotifier(repository);
// });

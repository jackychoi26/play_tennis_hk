import 'package:play_tennis_hk/features/chat/domain/entities/message.dart';

class Conversation {
  final String id;
  final List<String> participantIds;
  final Message? lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? name;
  final String? avatarUrl;
  final bool isGroup;
  final Map<String, DateTime> readReceipts;

  Conversation({
    required this.id,
    required this.participantIds,
    this.lastMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.name,
    this.avatarUrl,
    this.isGroup = false,
    Map<String, DateTime>? readReceipts,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        readReceipts = readReceipts ?? {};

  int getUnreadCount(String userId) {
    if (!readReceipts.containsKey(userId) || lastMessage == null) {
      return 0;
    }
    return lastMessage!.timestamp.isAfter(readReceipts[userId]!) ? 1 : 0;
  }

  Conversation updateLastMessage(Message message) {
    return Conversation(
      id: id,
      participantIds: participantIds,
      lastMessage: message,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      name: name,
      avatarUrl: avatarUrl,
      isGroup: isGroup,
      readReceipts: readReceipts,
    );
  }

  Conversation updateReadReceipt(String userId, DateTime timestamp) {
    final newReadReceipts = Map<String, DateTime>.from(readReceipts);
    newReadReceipts[userId] = timestamp;
    return Conversation(
      id: id,
      participantIds: participantIds,
      lastMessage: lastMessage,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      name: name,
      avatarUrl: avatarUrl,
      isGroup: isGroup,
      readReceipts: newReadReceipts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participantIds': participantIds,
      'lastMessage': lastMessage?.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'name': name,
      'avatarUrl': avatarUrl,
      'isGroup': isGroup,
      'readReceipts': readReceipts.map((k, v) => MapEntry(k, v.toIso8601String())),
    };
  }
}

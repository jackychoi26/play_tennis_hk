import 'dart:convert';
import 'dart:math';

enum MessageRole { sender, receiver }

enum MessageType { text, image, file, audio, video, system, notification }

enum MessageStatus { sent, delivered, read }

class Message implements Comparable<Message> {
  final String id;
  final String senderId;
  final List<String> receiverIds;
  final MessageRole role;
  final List<Content> content;
  final MessageType messageType;
  final DateTime timestamp;
  final MessageStatus status;
  final String? referenceMessageId;
  final DateTime? editedAt;
  final bool isDeleted;
  final String? locale;

  Message({
    required this.senderId,
    required this.receiverIds,
    required this.role,
    required this.content,
    required this.messageType,
    DateTime? timestamp,
    this.status = MessageStatus.sent,
    this.referenceMessageId,
    String? messageId,
    this.editedAt,
    this.isDeleted = false,
    this.locale,
  })  : assert(receiverIds.isNotEmpty, 'receiverIds must not be empty'),
        id = messageId ?? Random().nextInt(1000000).toString(),
        timestamp = timestamp ?? DateTime.now();

  @override
  int compareTo(Message other) => timestamp.compareTo(other.timestamp);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverIds': receiverIds,
      'role': role == MessageRole.sender ? 'sender' : 'receiver',
      'content': content.map((c) => c.toMap()).toList(),
      'messageType': messageType.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'status': status.toString().split('.').last,
      'referenceMessageId': referenceMessageId,
      'editedAt': editedAt?.toIso8601String(),
      'isDeleted': isDeleted,
      'locale': locale,
    };
  }
}

abstract class Content<T> {
  T get value;
  Map<String, dynamic> toMap();
}

class TextContent extends Content<String> {
  @override
  final String value;

  TextContent(this.value);

  @override
  Map<String, dynamic> toMap() => {'type': 'text', 'value': value};
}

class ImageContent extends Content<ImageData> {
  @override
  final ImageData value;

  ImageContent({
    required String url,
    required String thumbnailUrl,
    String? description,
    int? width,
    int? height,
    int? size,
  }) : value = ImageData(
          url: url,
          thumbnailUrl: thumbnailUrl,
          description: description,
          width: width,
          height: height,
          size: size,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'image',
      'value': value.toMap(),
    };
  }

  factory ImageContent.fromMap(Map<String, dynamic> map) {
    return ImageContent(
      url: map['value']['url'],
      thumbnailUrl: map['value']['thumbnailUrl'],
      description: map['value']['description'],
      width: map['value']['width'],
      height: map['value']['height'],
      size: map['value']['size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageContent.fromJson(String source) => ImageContent.fromMap(json.decode(source));

  ImageContent copyWith({
    String? url,
    String? thumbnailUrl,
    String? description,
    int? width,
    int? height,
    int? size,
  }) {
    return ImageContent(
      url: url ?? this.value.url,
      thumbnailUrl: thumbnailUrl ?? this.value.thumbnailUrl,
      description: description ?? this.value.description,
      width: width ?? this.value.width,
      height: height ?? this.value.height,
      size: size ?? this.value.size,
    );
  }

  @override
  String toString() => 'ImageContent(${value.toString()})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageContent &&
      other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class ImageData {
  final String url;
  final String thumbnailUrl;
  final String? description;
  final int? width;
  final int? height;
  final int? size; // in bytes

  ImageData({
    required this.url,
    required this.thumbnailUrl,
    this.description,
    this.width,
    this.height,
    this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'width': width,
      'height': height,
      'size': size,
    };
  }

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
      description: map['description'],
      width: map['width'],
      height: map['height'],
      size: map['size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageData.fromJson(String source) => ImageData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageData(url: $url, thumbnailUrl: $thumbnailUrl, description: $description, width: $width, height: $height, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageData &&
      other.url == url &&
      other.thumbnailUrl == thumbnailUrl &&
      other.description == description &&
      other.width == width &&
      other.height == height &&
      other.size == size;
  }

  @override
  int get hashCode {
    return url.hashCode ^
      thumbnailUrl.hashCode ^
      description.hashCode ^
      width.hashCode ^
      height.hashCode ^
      size.hashCode;
  }
}
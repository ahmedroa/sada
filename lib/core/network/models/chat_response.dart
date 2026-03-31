import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  final List<ChatChoice> choices;

  const ChatResponse({required this.choices});

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
}

@JsonSerializable()
class ChatChoice {
  final ChatMessage message;

  const ChatChoice({required this.message});

  factory ChatChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatChoiceFromJson(json);
}

@JsonSerializable()
class ChatMessage {
  final String role;
  final String content;

  const ChatMessage({required this.role, required this.content});

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

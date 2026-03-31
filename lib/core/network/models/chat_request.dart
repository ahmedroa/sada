import 'package:json_annotation/json_annotation.dart';

part 'chat_request.g.dart';

@JsonSerializable()
class ChatRequest {
  final String model;
  final List<Map<String, String>> messages;
  @JsonKey(name: 'max_tokens')
  final int maxTokens;

  const ChatRequest({
    required this.model,
    required this.messages,
    required this.maxTokens,
  });

  Map<String, dynamic> toJson() => _$ChatRequestToJson(this);
}

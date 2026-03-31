// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
  choices: (json['choices'] as List<dynamic>)
      .map((e) => ChatChoice.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{'choices': instance.choices};

ChatChoice _$ChatChoiceFromJson(Map<String, dynamic> json) => ChatChoice(
  message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatChoiceToJson(ChatChoice instance) =>
    <String, dynamic>{'message': instance.message};

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
  role: json['role'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

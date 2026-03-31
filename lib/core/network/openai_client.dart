import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sada/core/network/models/chat_request.dart';
import 'package:sada/core/network/models/chat_response.dart';

part 'openai_client.g.dart';

@RestApi(baseUrl: 'https://api.openai.com')
abstract class OpenAiClient {
  factory OpenAiClient(Dio dio, {String baseUrl}) = _OpenAiClient;

  @POST('/v1/chat/completions')
  Future<ChatResponse> sendMessage(@Body() ChatRequest request);
}

import 'package:dio/dio.dart';
import 'package:sada/core/network/openai_client.dart';

class OpenAiProvider {
  static const _apiKey =
      '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';

  static OpenAiClient? _client;

 
  static OpenAiClient get client {
    _client ??= OpenAiClient(
      Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15), // مهلة الاتصال
          receiveTimeout: const Duration(seconds: 30), // مهلة استقبال الرد
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer $_apiKey', 
          },
        ),
      ),
    );
    return _client!;
  }
}

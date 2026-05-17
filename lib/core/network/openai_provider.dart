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

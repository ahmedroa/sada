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

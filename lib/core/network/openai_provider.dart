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

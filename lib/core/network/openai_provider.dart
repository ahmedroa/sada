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

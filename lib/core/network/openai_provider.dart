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
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
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

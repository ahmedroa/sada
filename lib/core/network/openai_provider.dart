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

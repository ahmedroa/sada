import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sada/core/network/models/chat_request.dart';
import 'package:sada/core/network/openai_client.dart';

class ChatService {
  static String get _apiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  static const _model = 'gpt-3.5-turbo';

  static OpenAiClient? _client;

  static OpenAiClient get _openAiClient {
    if (_client != null) return _client!;
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
        },
      ),
    );
    _client = OpenAiClient(dio);
    return _client!;
  }

  // كاش للحدائق بعد أول جلب
  static List<Map<String, dynamic>>? _cachedGardens;

  static Future<List<Map<String, dynamic>>> _fetchGardens() async {
    if (_cachedGardens != null) return _cachedGardens!;

    final snapshot =
        await FirebaseFirestore.instance.collection('gardens').get();
    _cachedGardens =
        snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'name': data['name'] ?? '',
            'lat': (data['lat'] as num).toDouble(),
            'lng': (data['lng'] as num).toDouble(),
          };
        }).toList();

    debugPrint('Loaded ${_cachedGardens!.length} gardens from Firestore');
    return _cachedGardens!;
  }

  static const String _systemPromptBase = '''
أنت سَليل، مساعد ذكي متخصص في تطبيق سَدَى للحدائق. أجب دائماً باللغة العربية بأسلوب ودي ومختصر.

إجاباتك على الأسئلة الشائعة:

سؤال: هل يمكنني تقديم اقتراح للتطوير؟
الإجابة: نعم بالتأكيد! يمكنك تقديم اقتراحاتك عبر قسم "الشكاوي والاقتراحات" الموجود في صفحة الإعدادات. فريقنا يراجع كل الاقتراحات ويعمل على تطوير التطبيق باستمرار.

سؤال: كيف يمكنني اختيار الحديقة المناسبة؟
الإجابة: يمكنك اختيار الحديقة المناسبة من خلال:
١- تصفح الحدائق في قسم البحث ومشاهدة مؤشرات الاستدامة لكل حديقة
٢- قراءة تقييمات الزوار السابقين
٣- التحقق من المرافق المتاحة في كل حديقة
٤- اختيار الأقرب لموقعك

سؤال: كيف يمكنني تقييم الحدائق التي زرتها؟
الإجابة: يمكنك تقييم الحدائق بسهولة من خلال:
١- الذهاب لصفحة الحديقة التي زرتها
٢- الضغط على تبويب "تقييمات"
٣- اختيار عدد النجوم وكتابة رأيك
٤- الضغط على "إرسال" لنشر تقييمك

التزم بهذه الإجابات عند طرح هذه الأسئلة. وللأسئلة الأخرى المتعلقة بالحدائق، أجب بشكل مفيد ومختصر.
''';

  static double _distance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    final dlat = lat1 - lat2;
    final dlng = lng1 - lng2;
    return dlat * dlat + dlng * dlng;
  }

  static String _nearestGarden(
    List<Map<String, dynamic>> gardens,
    double userLat,
    double userLng,
  ) {
    Map<String, dynamic> nearest = gardens[0];
    double minDist = _distance(
      userLat,
      userLng,
      gardens[0]['lat'],
      gardens[0]['lng'],
    );

    for (final g in gardens.skip(1)) {
      final d = _distance(userLat, userLng, g['lat'], g['lng']);
      if (d < minDist) {
        minDist = d;
        nearest = g;
      }
    }
    return nearest['name'] as String;
  }

  static Future<String> sendMessage({
    required List<Map<String, String>> history,
    required String userMessage,
    double? userLat,
    double? userLng,
  }) async {
    final gardens = await _fetchGardens();

    final gardenNames = gardens.map((g) => '- ${g['name']}').join('\n');
    final systemPrompt =
        'الحدائق المتاحة في التطبيق:\n$gardenNames\n\n$_systemPromptBase';

    String messageToSend = userMessage;
    if (userLat != null && userLng != null && userMessage.contains('اقرب حديقة')) {
      final nearest = _nearestGarden(gardens, userLat, userLng);
      messageToSend =
          '$userMessage\n[موقع المستخدم: خط العرض $userLat، خط الطول $userLng — أقرب حديقة محسوبة: $nearest]';
    }

    final messages = <Map<String, String>>[
      {'role': 'system', 'content': systemPrompt},
      ...history,
      {'role': 'user', 'content': messageToSend},
    ];

    try {
      final response = await _openAiClient.sendMessage(
        ChatRequest(model: _model, messages: messages, maxTokens: 500),
      );

      debugPrint('ChatGPT: got ${response.choices.length} choice(s)');
      return response.choices.first.message.content.trim();
    } on DioException catch (e) {
      final status = e.response?.statusCode ?? 0;
      final body = e.response?.data?.toString() ?? e.message;
      debugPrint('ChatGPT error $status: $body');
      throw Exception('خطأ $status: $body');
    }
  }
}

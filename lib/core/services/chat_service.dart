import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sada/core/network/models/chat_request.dart';
import 'package:sada/core/network/openai_provider.dart';
import 'package:sada/core/services/garden_service.dart';

class ChatService {
  static const _model = 'gpt-3.5-turbo';

  static const _systemPrompt = '''
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

  static Future<String> sendMessage({
    required List<Map<String, String>> history,
    required String userMessage,
    double? userLat,
    double? userLng,
  }) async {
    final gardens = await GardenService.fetchGardens();

    final gardenNames = gardens.map((g) => '- ${g['name']}').join('\n');
    final systemContent = 'الحدائق المتاحة في التطبيق:\n$gardenNames\n\n$_systemPrompt';

    String messageToSend = userMessage;
    if (userLat != null && userLng != null && userMessage.contains('اقرب حديقة')) {
      final nearest = GardenService.findNearest(gardens, userLat, userLng);
      messageToSend =
          '$userMessage\n[موقع المستخدم: خط العرض $userLat، خط الطول $userLng — أقرب حديقة محسوبة: $nearest]';
    }

    try {
      final response = await OpenAiProvider.client.sendMessage(
        ChatRequest(
          model: _model,
          messages: [
            {'role': 'system', 'content': systemContent},
            ...history,
            {'role': 'user', 'content': messageToSend},
          ],
          maxTokens: 500,
        ),
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

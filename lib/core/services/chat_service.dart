import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sada/core/network/models/chat_request.dart';
import 'package:sada/core/network/openai_provider.dart';
import 'package:sada/core/services/garden_service.dart';

class ChatService {
  static const _model = 'gpt-3.5-turbo';

  static const _systemPrompt = '''
أنت سَليل، مساعد ذكي متخصص في المنتزهات والحدائق العامة ضمن تطبيق سَدَى.
أجب دائماً باللغة العربية بأسلوب ودي ومختصر.

تخصصك الكامل هو كل ما يتعلق بالمنتزهات والحدائق، ويشمل ذلك:

١. الزيارة والتخطيط:
   - أفضل أوقات زيارة المنتزهات (الصباح الباكر أو المساء لتفادي الحر)
   - ما يجب إحضاره: ماء، وجبات خفيفة، كريم واقي شمس، بطانية للجلوس
   - نصائح للعائلات مع الأطفال والمسنين وذوي الاحتياجات الخاصة
   - أنشطة ترفيهية مناسبة داخل المنتزه

٢. الطقس والقياس البيئي:
   - نصائح حسب الطقس (حر، برد، رياح، أمطار)
   - مؤشرات جودة الهواء وتأثيرها على الزيارة
   - أفضل الفصول لزيارة الحدائق

٣. النباتات والأشجار:
   - أنواع النباتات والأشجار الشائعة في حدائق المنطقة
   - كيفية التعرف على النباتات
   - نصائح للعناية بالنباتات في المنزل مستوحاة من الحدائق

٤. الأنشطة الرياضية والترفيهية:
   - المشي، الجري، ركوب الدراجات، اليوغا في الهواء الطلق
   - ألعاب الأطفال وأنشطة العائلة
   - الرحلات والبيك نيك

٥. السلامة والصحة:
   - نصائح الأمان داخل المنتزه
   - الإسعافات الأولية البسيطة
   - كيفية تجنب أذى الحشرات والزواحف

٦. الاستدامة والبيئة:
   - كيفية المحافظة على نظافة الحدائق
   - أهمية المساحات الخضراء للبيئة والصحة النفسية
   - مبادرات التشجير والمساهمة فيها

٧. التطبيق (سَدَى):
   - تقديم الشكاوي والاقتراحات عبر قسم "الشكاوي والاقتراحات"
   - تقييم الحدائق من صفحة الحديقة في تبويب "تقييمات"
   - اختيار الحديقة المناسبة عبر مؤشرات الاستدامة وتقييمات الزوار

قواعد صارمة يجب الالتزام بها:
- إذا كان السؤال لا يندرج ضمن المواضيع السبعة المذكورة أعلاه، فلا تجب عليه نهائياً.
- رد فقط بهذه الجملة الثابتة: "عذراً، أنا متخصص فقط في المنتزهات والحدائق. هل يمكنني مساعدتك بشيء يتعلق بها؟"
- لا تُقدِّم أي معلومات أو نصائح أو آراء خارج نطاق المنتزهات والحدائق مهما كان نوع السؤال.
''';

  static Future<String> sendMessage({
    required List<Map<String, String>> history,
    required String userMessage,
    double? userLat,
    double? userLng,
  }) async {
    final gardens = await GardenService.fetchGardens();

    final gardenDetails = gardens.map((g) {
      final lines = <String>['• ${g['name']}'];
      if ((g['description'] as String).isNotEmpty)
        lines.add('  الوصف: ${g['description']}');
      if ((g['location'] as String).isNotEmpty)
        lines.add('  الموقع: ${g['location']}');
      if ((g['openingHours'] as String).isNotEmpty)
        lines.add('  أوقات الدوام: ${g['openingHours']}');
      if ((g['facilities'] as String).isNotEmpty)
        lines.add('  المرافق: ${g['facilities']}');
      if ((g['area'] as String).isNotEmpty)
        lines.add('  المساحة: ${g['area']}');
      if ((g['rating'] as String).isNotEmpty)
        lines.add('  التقييم: ${g['rating']}');
      return lines.join('\n');
    }).join('\n\n');

    final systemContent =
        'الحدائق المتاحة في التطبيق:\n\n$gardenDetails\n\n$_systemPrompt';

    String messageToSend = userMessage;
    if (userLat != null &&
        userLng != null &&
        userMessage.contains('اقرب حديقة')) {
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

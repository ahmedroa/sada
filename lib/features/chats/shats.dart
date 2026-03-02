import 'package:flutter/material.dart';
import 'package:sada/core/widgets/curved_top_widget.dart';
import 'package:sada/features/chats/chat_screen.dart';

class Shats extends StatelessWidget {
  const Shats({super.key});

  Widget _buildQuestionItem(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ChatScreen(initialQuestion: text)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CurvedTopWidget(),

          SizedBox(height: 20),
          Image.asset('img/GreenGenieLogocropped.png', width: 120, height: 120, fit: BoxFit.cover),
          Text(
            'اسأل  سَليل ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff159148)),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'سَليل ، خبيرك الأخضر ! يختصر لك البحث ويأخذك لأجمل المساحات الخضراء ..',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff98C13F)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),

          _buildQuestionItem(context, 'هل يمكنني تقديم اقتراح للتطوير ؟'),
          SizedBox(height: 10),
          _buildQuestionItem(context, 'كيف يمكنني اختيار الحديقة المناسبة؟'),
          SizedBox(height: 10),
          _buildQuestionItem(context, 'كيف يمكنني تقييم الحدائق التي زرتها؟'),
          SizedBox(height: 10),
          _buildQuestionItem(context, 'اين تقع اقرب حديقة من منزلي ؟'),
        ],
      ),
    );
  }
}

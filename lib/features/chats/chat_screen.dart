import 'package:flutter/material.dart';
import 'package:sada/core/services/chat_service.dart';
import 'package:sada/core/theme/colors.dart';

class ChatScreen extends StatefulWidget {
  final String initialQuestion;

  const ChatScreen({super.key, required this.initialQuestion});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [];
  // تاريخ المحادثة لإرساله لـ ChatGPT
  final List<Map<String, String>> _history = [];

  bool _isLoading = false;
  bool _showHint = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialQuestion.trim().isEmpty) {
      _showHint = true;
    } else {
      _sendToGpt(widget.initialQuestion);
    }
  }

  Future<void> _sendToGpt(String userText) async {
    if (userText.trim().isEmpty) return;

    setState(() {
      _showHint = false;
      _messages.add(_ChatMessage(text: userText, isUser: true));
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final reply = await ChatService.sendMessage(
        history: List.from(_history),
        userMessage: userText,
      );

      _history.add({'role': 'user', 'content': userText});
      _history.add({'role': 'assistant', 'content': reply});

      if (mounted) {
        setState(() {
          _messages.add(_ChatMessage(text: reply, isUser: false));
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Chat error: $e');
      if (mounted) {
        setState(() {
          _messages.add(
            _ChatMessage(text: 'عذراً، حدث خطأ: $e', isUser: false),
          );
          _isLoading = false;
        });
      }
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;
    _controller.clear();
    _sendToGpt(text);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                  Image.asset(
                    'img/GreenGenieLogocropped.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Text(
              'أهلًا ، انا سَليل مساعدك الشخصي  ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorsManager.kPrimaryColo,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  if (_showHint)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF0FAF4),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xff0D986A)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'يمكنك سؤالي عن أي شيء يتعلق بالمنتزهات والحدائق، مثل:\n\n'
                            ' أفضل أوقات الزيارة ونصائح التخطيط\n'
                            ' النباتات والأشجار وأنواعها\n'
                            ' الأنشطة الرياضية والترفيهية\n'
                            'نصائح الطقس وجودة الهواء\n'
                            'السلامة والصحة داخل المنتزه\n'
                            ' الاستدامة والمحافظة على البيئة\n'
                            ' معلومات عن حدائق بعينها في التطبيق',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 2,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length)
                        return _buildTypingIndicator();
                      return _buildBubble(_messages[index]);
                    },
                  ),
                ],
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(_ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: msg.isUser
              ? const Color(0xffC0E8BB).withOpacity(.62)
              : const Color(0xff8BE481).withOpacity(.62),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: msg.isUser
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: msg.isUser
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
          border: Border.all(color: ColorsManager.kPrimaryColo, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            fontSize: 16,
            color: msg.isUser ? Colors.black : Colors.black87,
            height: 1.5,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xff8BE481).withOpacity(.62),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
          border: Border.all(color: ColorsManager.kPrimaryColo, width: 1),
        ),
        child: const SizedBox(width: 40, height: 16, child: _TypingDots()),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _isLoading ? null : _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _isLoading ? Colors.grey : const Color(0xff159148),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              textDirection: TextDirection.rtl,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                filled: true,
                fillColor: const Color(0xffF5F5F5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();
  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final opacity = ((_controller.value * 3 - i) % 1).clamp(0.2, 1.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: const Color(0xff159148).withOpacity(opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}

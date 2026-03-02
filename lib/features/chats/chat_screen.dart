import 'package:flutter/material.dart';
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
  final Set<int> _usedOptions = {};

  @override
  void initState() {
    super.initState();
    _messages.add(_ChatMessage(text: widget.initialQuestion, isUser: true));
    _messages.add(_ChatMessage(text: 'ما هو هدفك من الزيارة ؟', isUser: false));
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _controller.clear();
    });

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
      // backgroundColor: const Color(0xffF5F5F5),
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.5,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       const CircleAvatar(
      //         radius: 16,
      //         backgroundColor: Color(0xff159148),
      //         child: Icon(Icons.eco, color: Colors.white, size: 16),
      //       ),
      //       const SizedBox(width: 8),
      //       const Text(
      //         'سَليل',
      //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      //       ),
      //     ],
      //   ),
      // ),
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
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
                    ),
                  ),
                  Image.asset('img/GreenGenieLogocropped.png', width: 80, height: 80, fit: BoxFit.cover),
                ],
              ),
            ),
            Text(
              'أهلًا ، انا سَليل مساعدك الشخصي  ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorsManager.kPrimaryColo),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBubble(msg),
                      if (msg.options != null && !_usedOptions.contains(index))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, top: 4),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: msg.options!.map((option) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _usedOptions.add(index);
                                    _messages.add(_ChatMessage(text: option, isUser: true));
                                  });
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (_scrollController.hasClients) {
                                      _scrollController.animateTo(
                                        _scrollController.position.maxScrollExtent,
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      );
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: const Color(0xff159148), width: 1.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    option,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff159148),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  );
                },
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
      child: Column(
        crossAxisAlignment: msg.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: msg.isUser ? const Color(0xffC0E8BB).withOpacity(.62) : Color(0xff8BE481).withOpacity(.62),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: msg.isUser ? const Radius.circular(16) : const Radius.circular(4),
                bottomRight: msg.isUser ? const Radius.circular(4) : const Radius.circular(16),
              ),
              border: Border.all(color: msg.isUser ? ColorsManager.kPrimaryColo : ColorsManager.kPrimaryColo, width: 1),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: Text(
              msg.text,
              style: TextStyle(fontSize: 16, color: msg.isUser ? Colors.black : Colors.black87, height: 1.5),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(color: Color(0xff159148), shape: BoxShape.circle),
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
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                filled: true,
                fillColor: const Color(0xffF5F5F5),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
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
  final List<String>? options;

  _ChatMessage({required this.text, required this.isUser, this.options});
}

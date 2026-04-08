import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String? time;

  const ChatMessage({required this.text, required this.isUser, this.time});
}

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    const ChatMessage(text: 'Hi, how can I help you?', isUser: false),
    const ChatMessage(
      text: 'Hello, I ordered two fried chicken burgers. can I know how much time it will get to arrive?',
      isUser: true,
    ),
    const ChatMessage(text: 'Ok, please let me check!', isUser: false),
    const ChatMessage(text: 'Sure...', isUser: true),
    const ChatMessage(
      text: "It'll get 25 minutes to arrive to your address",
      isUser: false,
      time: '25 minutes ago',
    ),
    const ChatMessage(text: 'Ok, thanks you for your support', isUser: true),
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: _textController.text.trim(), isUser: true));
      _textController.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildMessageBubble(msg);
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark, size: 20),
          ),
          const Spacer(),
          const Icon(Icons.menu, color: AppColors.textDark, size: 24),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (message.isUser) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  message.text,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // User avatar
            ClipOval(
              child: Image.network(
                'https://images.unsplash.com/photo-1494790108755-2616b612b494?w=80',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 36,
                  height: 36,
                  color: AppColors.primary,
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 60),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Support agent avatar
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.darkCard,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.chatBubbleAgent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textDark,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (message.time != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 44),
                child: Text(
                  message.time!,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppColors.textLight,
                  ),
                ),
              ),
          ],
        ),
      );
    }
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 10, 16, MediaQuery.of(context).padding.bottom + 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.bgGrey,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _textController,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: AppColors.textDark),
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14, color: AppColors.textGrey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

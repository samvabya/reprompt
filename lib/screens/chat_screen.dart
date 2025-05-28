import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../models/chat_message.dart';
import '../models/ai_model.dart';
import '../services/chat_service.dart';
import '../constants/app_constants.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';
import '../widgets/welcome_screen.dart';
import '../widgets/model_indicator.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/app_drawer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ChatService _chatService = ChatService();
  bool _isTyping = false;
  AIModel _currentModel = AppConstants.availableModels.first;

  @override
  void initState() {
    super.initState();
    _checkApiKey();
  }

  void _checkApiKey() {
    if (!_chatService.hasApiKey) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Error: OPENROUTER_API_KEY not found in .env file',
            isUser: false,
            isError: true,
          ));
        });
      });
    }
  }

  Future<void> _sendMessage([String? customMessage]) async {
    final messageText = customMessage ?? _messageController.text.trim();
    if (messageText.isEmpty) return;

    if (customMessage == null) {
      _messageController.clear();
    }

    setState(() {
      _messages.add(ChatMessage(
        text: messageText,
        isUser: true,
      ));
      _isTyping = true;
    });

    try {
      final response =
          await _chatService.sendMessage(messageText, _currentModel);

      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
        ));
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Error: ${e.toString()}',
          isUser: false,
          isError: true,
        ));
        _isTyping = false;
      });
    }
  }

  void _clearConversation() {
    setState(() {
      _messages.clear();
      _chatService.clearHistory();
    });
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About ${AppConstants.appName}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reprompt is an AI chat application that uses OpenRouter to access multiple AI models.',
            ),
            SizedBox(height: 16),
            Text(
              'To use this app, you need to provide an OpenRouter API key in the .env file.',
            ),
            SizedBox(height: 16),
            Text(
              'Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('• Multiple AI models'),
            Text('• Free model options'),
            Text('• Conversation history'),
            Text('• Model switching'),
            Text('• Beautiful Material 3 UI'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/reprompt.png',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(FeatherIcons.cpu),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'Clear conversation',
            );
          }),
          IconButton(
            icon: const Icon(FeatherIcons.refreshCw),
            onPressed: _clearConversation,
            tooltip: 'Clear conversation',
          ),
        ],
      ),
      drawer: AppDrawer(
        currentModel: _currentModel,
        onModelSelected: (model) {
          setState(() {
            _currentModel = model;
          });
        },
        onClearConversation: _clearConversation,
        onShowAbout: _showAboutDialog,
      ),
      body: Builder(builder: (context) {
        return GestureDetector(
          onHorizontalDragStart: (details) => Scaffold.of(context).openDrawer(),
          child: Column(
            children: [
              ModelIndicator(currentModel: _currentModel),
              Expanded(
                child: _messages.isEmpty
                    ? WelcomeScreen(onSuggestionTap: _sendMessage)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return MessageBubble(message: _messages[index]);
                        },
                      ),
              ),
              if (_isTyping) const TypingIndicator(),
              MessageInput(
                controller: _messageController,
                onSend: () => _sendMessage(),
                isLoading: _isTyping,
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

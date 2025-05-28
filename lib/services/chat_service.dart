import '../models/chat_message.dart';
import '../models/ai_model.dart';
import 'openrouter_service.dart';

class ChatService {
  final OpenRouterService _openRouterService = OpenRouterService();
  final List<Map<String, dynamic>> _conversationHistory = [];

  List<Map<String, dynamic>> get conversationHistory => List.unmodifiable(_conversationHistory);

  void addUserMessage(String message) {
    _conversationHistory.add({
      "role": "user",
      "content": message,
    });
  }

  void addAssistantMessage(String message) {
    _conversationHistory.add({
      "role": "assistant",
      "content": message,
    });
  }

  Future<String> sendMessage(String message, AIModel model) async {
    addUserMessage(message);
    
    final response = await _openRouterService.sendMessage(
      model: model.id,
      messages: _conversationHistory,
    );
    
    addAssistantMessage(response);
    return response;
  }

  void clearHistory() {
    _conversationHistory.clear();
  }

  bool get hasApiKey => _openRouterService.hasApiKey;
}

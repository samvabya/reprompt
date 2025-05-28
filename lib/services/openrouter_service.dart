import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import '../constants/app_constants.dart';

class OpenRouterService {
  static final OpenRouterService _instance = OpenRouterService._internal();
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();

  final String _apiKey = dotenv.dotenv.env[AppConstants.envKeyOpenRouter] ?? '';

  bool get hasApiKey => _apiKey.isNotEmpty;

  Future<String> sendMessage({
    required String model,
    required List<Map<String, dynamic>> messages,
    double temperature = 0.7,
    int maxTokens = 1024,
    double topP = 0.9,
  }) async {
    if (!hasApiKey) {
      throw Exception('OpenRouter API key not found in .env file');
    }

    try {
      final url = Uri.parse(AppConstants.openRouterBaseUrl);

      final requestBody = {
        "model": model,
        "messages": messages,
        "temperature": temperature,
        "max_tokens": maxTokens,
        "top_p": topP,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'HTTP-Referer': 'https://reprompt-app.com',
          'X-Title': 'Reprompt AI Chat',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['choices'] != null && 
            data['choices'].isNotEmpty &&
            data['choices'][0]['message'] != null &&
            data['choices'][0]['message']['content'] != null) {
          
          return data['choices'][0]['message']['content'];
        } else {
          throw Exception('Invalid response format from API');
        }
      } else {
        final errorData = json.decode(response.body);
        throw Exception('API Error ${response.statusCode}: ${errorData['error']['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

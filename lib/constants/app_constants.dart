import '../models/ai_model.dart';

class AppConstants {
  static const String appName = 'Reprompt';
  static const String openRouterBaseUrl =
      'https://openrouter.ai/api/v1/chat/completions';
  static const String envKeyOpenRouter = 'OPENROUTER_API_KEY';

  static const List<AIModel> availableModels = [
    AIModel(
      id: 'google/gemma-3n-e4b-it:free',
      name: 'Google Gemma 3n E4B IT',
      provider: 'Google',
      isFree: true,
      description: 'High-performance model for various tasks',
    ),
    AIModel(
      id: 'google/gemini-2.0-flash-exp:free',
      name: 'Gemini 2.0 Flash',
      provider: 'Google',
      isFree: true,
      description: 'Fast and efficient model for general conversations',
    ),
    AIModel(
      id: 'meta-llama/llama-3.2-3b-instruct:free',
      name: 'Meta Llama 3.2 3B Instruct',
      provider: 'Meta',
      isFree: true,
      description: 'Instruction-tuned model for helpful responses',
    ),
    AIModel(
      id: 'deepseek/deepseek-r1:free',
      name: 'DeepSeek: R1',
      provider: 'DeepSeek',
      isFree: true,
      description: 'High-performance model for various tasks',
    ),
    AIModel(
      id: 'deepseek/deepseek-chat:free',
      name: 'DeepSeek V3',
      provider: 'DeepSeek',
      isFree: true,
      description: 'General-purpose model with strong reasoning',
    ),
    AIModel(
      id: 'mistralai/devstral-small:free',
      name: 'Mistral: Devstral Small',
      provider: 'Mistral',
      isFree: true,
      description: 'Compact model with large context window',
    ),
    AIModel(
      id: 'microsoft/phi-4-reasoning:free',
      name: 'Microsoft: Phi 4 Reasoning',
      provider: 'Microsoft',
      isFree: true,
      description: 'Fine-tuned for helpful and harmless responses',
    ),
    AIModel(
      id: 'qwen/qwen3-30b-a3b:free',
      name: 'Qwen3 30B A3B',
      provider: 'Qwen',
      isFree: true,
      description: 'General-purpose model with strong reasoning',
    ),
  ];

  static const List<String> suggestionPrompts = [
    'Tell me a joke',
    'Write a poem about nature',
    'Explain quantum computing',
    'Give me a recipe idea',
  ];
}

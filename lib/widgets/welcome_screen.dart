import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../constants/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(String) onSuggestionTap;

  const WelcomeScreen({
    super.key,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.messageCircle,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to ${AppConstants.appName}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Start a conversation with AI models via OpenRouter. Choose from various models and enjoy free AI chat.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
              ),
            ),
            const SizedBox(height: 32),
            _buildSuggestionChips(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChips(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: AppConstants.suggestionPrompts.map((suggestion) {
        return ActionChip(
          label: Text(suggestion),
          avatar: Icon(
            FeatherIcons.zap,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => onSuggestionTap(suggestion),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primary
              : message.isError
                  ? Theme.of(context).colorScheme.errorContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  message.isUser
                      ? FeatherIcons.user
                      : message.isError
                          ? FeatherIcons.alertCircle
                          : FeatherIcons.cpu,
                  size: 16,
                  color: _getIconColor(context),
                ),
                const SizedBox(width: 8),
                Text(
                  message.isUser ? 'You' : 'AI Assistant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message.text,
              style: TextStyle(
                color: _getContentColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor(BuildContext context) {
    if (message.isUser) {
      return Theme.of(context).colorScheme.onPrimary;
    } else if (message.isError) {
      return Theme.of(context).colorScheme.error;
    } else {
      return Theme.of(context).colorScheme.onSecondaryContainer;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (message.isUser) {
      return Theme.of(context).colorScheme.onPrimary;
    } else if (message.isError) {
      return Theme.of(context).colorScheme.error;
    } else {
      return Theme.of(context).colorScheme.onSecondaryContainer;
    }
  }

  Color _getContentColor(BuildContext context) {
    if (message.isUser) {
      return Theme.of(context).colorScheme.onPrimary;
    } else if (message.isError) {
      return Theme.of(context).colorScheme.onErrorContainer;
    } else {
      return Theme.of(context).colorScheme.onSecondaryContainer;
    }
  }
}

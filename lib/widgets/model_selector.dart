import 'package:flutter/material.dart';
import '../models/ai_model.dart';
import '../constants/app_constants.dart';

class ModelSelector extends StatelessWidget {
  final AIModel currentModel;
  final Function(AIModel) onModelSelected;

  const ModelSelector({
    super.key,
    required this.currentModel,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select AI Model'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: AppConstants.availableModels.length,
          itemBuilder: (context, index) {
            final model = AppConstants.availableModels[index];
            return RadioListTile<AIModel>(
              title: Text(
                model.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Provider: ${model.provider}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  if (model.description != null)
                    Text(
                      model.description!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
              value: model,
              groupValue: currentModel,
              onChanged: (value) {
                if (value != null) {
                  onModelSelected(value);
                  Navigator.of(context).pop();
                }
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

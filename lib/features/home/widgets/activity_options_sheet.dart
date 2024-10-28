import 'package:flutter/material.dart';
import 'package:goatrik_hub/features/home/models/activity.dart';

class ActivityOptionsSheet extends StatelessWidget {
  const ActivityOptionsSheet({super.key, required Activity activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Redigera'),
              onTap: () {
                Navigator.pop(context);
                // Implementera redigering här
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Radera'),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
              onTap: () {
                Navigator.pop(context);
                // Implementera borttagning här
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../enums/activity_enums.dart';
import '../providers/home_provider.dart';
import 'activity_options_sheet.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.task:
        return Icons.check_circle_outline;
      case ActivityType.event:
        return Icons.event;
      case ActivityType.reminder:
        return Icons.alarm;
    }
  }

  Color _getStatusColor(BuildContext context, ActivityStatus status) {
    switch (status) {
      case ActivityStatus.pending:
        return Theme.of(context).colorScheme.primary.withOpacity(0.6);
      case ActivityStatus.inProgress:
        return Theme.of(context).colorScheme.tertiary;
      case ActivityStatus.completed:
        return Theme.of(context).colorScheme.primary;
      case ActivityStatus.cancelled:
        return Theme.of(context).colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Senaste Aktiviteter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            homeProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : homeProvider.activities.isEmpty
                    ? const Center(
                        child: Text('Inga aktiviteter att visa'),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeProvider.activities.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final activity = homeProvider.activities[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getStatusColor(
                                context,
                                activity.status,
                              ).withOpacity(0.1),
                              child: Icon(
                                _getActivityIcon(activity.type),
                                color: _getStatusColor(
                                  context,
                                  activity.status,
                                ),
                              ),
                            ),
                            title: Text(
                              activity.title,
                              style: TextStyle(
                                decoration: activity.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  timeago.format(activity.createdAt),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                if (activity.description.isNotEmpty)
                                  Text(
                                    activity.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      ActivityOptionsSheet(activity: activity),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                            ),
                            onTap: () {
                              // Implementera navigation till aktivitetsdetaljer här
                            },
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/activity_enums.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String title,
    required String description,
    required DateTime createdAt,
    required ActivityStatus status,
    required ActivityType type,
    @Default(ActivityPriority.medium) ActivityPriority priority,
    String? location,
    String? notes,
    @Default([]) List<String> tags,
    @Default(false) bool isCompleted,
    DateTime? dueDate,
    DateTime? completedAt,
    DateTime? updatedAt,
    String? assignedTo,
    @Default(0) int duration,
    @Default(0) double progress,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

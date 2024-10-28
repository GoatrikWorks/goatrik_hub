import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ActivityType {
  @JsonValue('task')
  task,
  @JsonValue('event')
  event,
  @JsonValue('reminder')
  reminder;
}

@JsonEnum()
enum ActivityStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled;
}

@JsonEnum()
enum ActivityFilter {
  all,
  pending,
  inProgress,
  completed,
  cancelled,
  today,
  thisWeek,
  thisMonth,
}

@JsonEnum()
enum ActivitySort {
  newest,
  oldest,
  alphabetical,
  priority,
  status,
}

@JsonEnum()
enum ActivityView {
  list,
  grid,
  calendar,
  timeline,
}

@JsonEnum()
enum ActivityPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high;
}

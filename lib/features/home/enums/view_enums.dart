import 'package:json_annotation/json_annotation.dart';

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

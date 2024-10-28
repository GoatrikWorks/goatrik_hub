// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecode(_$ActivityStatusEnumMap, json['status']),
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      priority:
          $enumDecodeNullable(_$ActivityPriorityEnumMap, json['priority']) ??
              ActivityPriority.medium,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isCompleted: json['isCompleted'] as bool? ?? false,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      assignedTo: json['assignedTo'] as String?,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'priority': _$ActivityPriorityEnumMap[instance.priority]!,
      'location': instance.location,
      'notes': instance.notes,
      'tags': instance.tags,
      'isCompleted': instance.isCompleted,
      'dueDate': instance.dueDate?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'assignedTo': instance.assignedTo,
      'duration': instance.duration,
      'progress': instance.progress,
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.pending: 'pending',
  ActivityStatus.inProgress: 'in_progress',
  ActivityStatus.completed: 'completed',
  ActivityStatus.cancelled: 'cancelled',
};

const _$ActivityTypeEnumMap = {
  ActivityType.task: 'task',
  ActivityType.event: 'event',
  ActivityType.reminder: 'reminder',
};

const _$ActivityPriorityEnumMap = {
  ActivityPriority.low: 'low',
  ActivityPriority.medium: 'medium',
  ActivityPriority.high: 'high',
};

import '../models/activity.dart';

extension ActivityX on Activity {
  bool get isOverdue {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && !isCompleted;
  }

  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
        dueDate!.month == now.month &&
        dueDate!.day == now.day;
  }

  Duration get timeUntilDue {
    if (dueDate == null) return const Duration();
    return dueDate!.difference(DateTime.now());
  }

  String get formattedDuration {
    if (duration == 0) return '';
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    if (hours > 0) {
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }
    return '${minutes}m';
  }

  bool get isNew {
    return DateTime.now().difference(createdAt).inHours < 24;
  }
}

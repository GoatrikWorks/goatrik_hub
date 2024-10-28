import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../enums/activity_enums.dart';
import '../models/activity.dart';
import '../repositories/home_repository.dart';
import 'home_state.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepository _repository;
  HomeState _state = const HomeState();

  HomeProvider({HomeRepository? repository})
      : _repository = repository ?? HomeRepository();

  HomeState get state => _state;
  List<Activity> get activities => _state.activities;
  bool get isLoading => _state.isLoading;
  String? get error => _state.error;
  Activity? get selectedActivity => _state.selectedActivity;

  void _setState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchActivities() async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));
      final activities = await _repository.getActivities();
      _setState(_state.copyWith(
        activities: activities,
        isLoading: false,
      ));
    } catch (e) {
      _setState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> addActivity(String title, String description) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));
      final newActivity = Activity(
        id: const Uuid().v4(),
        title: title,
        description: description,
        createdAt: DateTime.now(),
        type: ActivityType.task,
        status: ActivityStatus.pending,
        priority: ActivityPriority.medium,
      );

      await _repository.createActivity(newActivity);
      await fetchActivities();
    } catch (e) {
      _setState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> updateActivity(Activity activity) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));
      await _repository.updateActivity(activity);
      await fetchActivities();
    } catch (e) {
      _setState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> deleteActivity(String id) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));
      await _repository.deleteActivity(id);
      await fetchActivities();
    } catch (e) {
      _setState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void setFilter(ActivityFilter filter) {
    _setState(_state.copyWith(filter: filter));
  }

  void setSort(ActivitySort sort) {
    _setState(_state.copyWith(sort: sort));
  }

  List<Activity> get filteredAndSortedActivities {
    List<Activity> filtered = List.from(activities);

    // Apply filter
    switch (_state.filter) {
      case ActivityFilter.pending:
        filtered =
            filtered.where((a) => a.status == ActivityStatus.pending).toList();
        break;
      case ActivityFilter.inProgress:
        filtered = filtered
            .where((a) => a.status == ActivityStatus.inProgress)
            .toList();
        break;
      case ActivityFilter.completed:
        filtered = filtered
            .where((a) => a.status == ActivityStatus.completed)
            .toList();
        break;
      case ActivityFilter.cancelled:
        filtered = filtered
            .where((a) => a.status == ActivityStatus.cancelled)
            .toList();
        break;
      case ActivityFilter.today:
        final now = DateTime.now();
        filtered = filtered
            .where((a) =>
                a.createdAt.year == now.year &&
                a.createdAt.month == now.month &&
                a.createdAt.day == now.day)
            .toList();
        break;
      case ActivityFilter.thisWeek:
        final now = DateTime.now();
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filtered =
            filtered.where((a) => a.createdAt.isAfter(startOfWeek)).toList();
        break;
      case ActivityFilter.thisMonth:
        final now = DateTime.now();
        filtered = filtered
            .where((a) =>
                a.createdAt.year == now.year && a.createdAt.month == now.month)
            .toList();
        break;
      case ActivityFilter.all:
        break;
    }

    // Apply sort
    switch (_state.sort) {
      case ActivitySort.newest:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ActivitySort.oldest:
        filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case ActivitySort.alphabetical:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ActivitySort.priority:
        filtered.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case ActivitySort.status:
        filtered.sort((a, b) => a.status.index.compareTo(b.status.index));
        break;
    }

    return filtered;
  }

  void clearError() {
    _setState(_state.copyWith(error: null));
  }
}

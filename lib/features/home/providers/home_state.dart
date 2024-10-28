import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/activity_enums.dart';
import '../models/activity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Activity> activities,
    Activity? selectedActivity,
    @Default(false) bool isLoading,
    String? error,
    @Default(ActivityFilter.all) ActivityFilter filter,
    @Default(ActivitySort.newest) ActivitySort sort,
    @Default(ActivityView.list) ActivityView view,
  }) = _HomeState;
}

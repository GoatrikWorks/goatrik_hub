// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  List<Activity> get activities => throw _privateConstructorUsedError;
  Activity? get selectedActivity => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  ActivityFilter get filter => throw _privateConstructorUsedError;
  ActivitySort get sort => throw _privateConstructorUsedError;
  ActivityView get view => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<Activity> activities,
      Activity? selectedActivity,
      bool isLoading,
      String? error,
      ActivityFilter filter,
      ActivitySort sort,
      ActivityView view});

  $ActivityCopyWith<$Res>? get selectedActivity;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activities = null,
    Object? selectedActivity = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? filter = null,
    Object? sort = null,
    Object? view = null,
  }) {
    return _then(_value.copyWith(
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<Activity>,
      selectedActivity: freezed == selectedActivity
          ? _value.selectedActivity
          : selectedActivity // ignore: cast_nullable_to_non_nullable
              as Activity?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ActivityFilter,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as ActivitySort,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as ActivityView,
    ) as $Val);
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityCopyWith<$Res>? get selectedActivity {
    if (_value.selectedActivity == null) {
      return null;
    }

    return $ActivityCopyWith<$Res>(_value.selectedActivity!, (value) {
      return _then(_value.copyWith(selectedActivity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Activity> activities,
      Activity? selectedActivity,
      bool isLoading,
      String? error,
      ActivityFilter filter,
      ActivitySort sort,
      ActivityView view});

  @override
  $ActivityCopyWith<$Res>? get selectedActivity;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activities = null,
    Object? selectedActivity = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? filter = null,
    Object? sort = null,
    Object? view = null,
  }) {
    return _then(_$HomeStateImpl(
      activities: null == activities
          ? _value._activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<Activity>,
      selectedActivity: freezed == selectedActivity
          ? _value.selectedActivity
          : selectedActivity // ignore: cast_nullable_to_non_nullable
              as Activity?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ActivityFilter,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as ActivitySort,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as ActivityView,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {final List<Activity> activities = const [],
      this.selectedActivity,
      this.isLoading = false,
      this.error,
      this.filter = ActivityFilter.all,
      this.sort = ActivitySort.newest,
      this.view = ActivityView.list})
      : _activities = activities;

  final List<Activity> _activities;
  @override
  @JsonKey()
  List<Activity> get activities {
    if (_activities is EqualUnmodifiableListView) return _activities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activities);
  }

  @override
  final Activity? selectedActivity;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final ActivityFilter filter;
  @override
  @JsonKey()
  final ActivitySort sort;
  @override
  @JsonKey()
  final ActivityView view;

  @override
  String toString() {
    return 'HomeState(activities: $activities, selectedActivity: $selectedActivity, isLoading: $isLoading, error: $error, filter: $filter, sort: $sort, view: $view)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._activities, _activities) &&
            (identical(other.selectedActivity, selectedActivity) ||
                other.selectedActivity == selectedActivity) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.view, view) || other.view == view));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activities),
      selectedActivity,
      isLoading,
      error,
      filter,
      sort,
      view);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final List<Activity> activities,
      final Activity? selectedActivity,
      final bool isLoading,
      final String? error,
      final ActivityFilter filter,
      final ActivitySort sort,
      final ActivityView view}) = _$HomeStateImpl;

  @override
  List<Activity> get activities;
  @override
  Activity? get selectedActivity;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  ActivityFilter get filter;
  @override
  ActivitySort get sort;
  @override
  ActivityView get view;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

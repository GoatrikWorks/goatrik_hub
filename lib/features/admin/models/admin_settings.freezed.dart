// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminSettings _$AdminSettingsFromJson(Map<String, dynamic> json) {
  return _AdminSettings.fromJson(json);
}

/// @nodoc
mixin _$AdminSettings {
  bool get enableUserRegistration => throw _privateConstructorUsedError;
  bool get requireEmailVerification => throw _privateConstructorUsedError;
  int get maxLoginAttempts => throw _privateConstructorUsedError;
  Duration get sessionTimeout => throw _privateConstructorUsedError;
  List<String> get allowedDomains => throw _privateConstructorUsedError;
  bool get maintenanceMode => throw _privateConstructorUsedError;
  String? get maintenanceMessage => throw _privateConstructorUsedError;
  Map<String, dynamic> get customSettings => throw _privateConstructorUsedError;

  /// Serializes this AdminSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminSettingsCopyWith<AdminSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminSettingsCopyWith<$Res> {
  factory $AdminSettingsCopyWith(
          AdminSettings value, $Res Function(AdminSettings) then) =
      _$AdminSettingsCopyWithImpl<$Res, AdminSettings>;
  @useResult
  $Res call(
      {bool enableUserRegistration,
      bool requireEmailVerification,
      int maxLoginAttempts,
      Duration sessionTimeout,
      List<String> allowedDomains,
      bool maintenanceMode,
      String? maintenanceMessage,
      Map<String, dynamic> customSettings});
}

/// @nodoc
class _$AdminSettingsCopyWithImpl<$Res, $Val extends AdminSettings>
    implements $AdminSettingsCopyWith<$Res> {
  _$AdminSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableUserRegistration = null,
    Object? requireEmailVerification = null,
    Object? maxLoginAttempts = null,
    Object? sessionTimeout = null,
    Object? allowedDomains = null,
    Object? maintenanceMode = null,
    Object? maintenanceMessage = freezed,
    Object? customSettings = null,
  }) {
    return _then(_value.copyWith(
      enableUserRegistration: null == enableUserRegistration
          ? _value.enableUserRegistration
          : enableUserRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
      requireEmailVerification: null == requireEmailVerification
          ? _value.requireEmailVerification
          : requireEmailVerification // ignore: cast_nullable_to_non_nullable
              as bool,
      maxLoginAttempts: null == maxLoginAttempts
          ? _value.maxLoginAttempts
          : maxLoginAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      sessionTimeout: null == sessionTimeout
          ? _value.sessionTimeout
          : sessionTimeout // ignore: cast_nullable_to_non_nullable
              as Duration,
      allowedDomains: null == allowedDomains
          ? _value.allowedDomains
          : allowedDomains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maintenanceMode: null == maintenanceMode
          ? _value.maintenanceMode
          : maintenanceMode // ignore: cast_nullable_to_non_nullable
              as bool,
      maintenanceMessage: freezed == maintenanceMessage
          ? _value.maintenanceMessage
          : maintenanceMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      customSettings: null == customSettings
          ? _value.customSettings
          : customSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminSettingsImplCopyWith<$Res>
    implements $AdminSettingsCopyWith<$Res> {
  factory _$$AdminSettingsImplCopyWith(
          _$AdminSettingsImpl value, $Res Function(_$AdminSettingsImpl) then) =
      __$$AdminSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enableUserRegistration,
      bool requireEmailVerification,
      int maxLoginAttempts,
      Duration sessionTimeout,
      List<String> allowedDomains,
      bool maintenanceMode,
      String? maintenanceMessage,
      Map<String, dynamic> customSettings});
}

/// @nodoc
class __$$AdminSettingsImplCopyWithImpl<$Res>
    extends _$AdminSettingsCopyWithImpl<$Res, _$AdminSettingsImpl>
    implements _$$AdminSettingsImplCopyWith<$Res> {
  __$$AdminSettingsImplCopyWithImpl(
      _$AdminSettingsImpl _value, $Res Function(_$AdminSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableUserRegistration = null,
    Object? requireEmailVerification = null,
    Object? maxLoginAttempts = null,
    Object? sessionTimeout = null,
    Object? allowedDomains = null,
    Object? maintenanceMode = null,
    Object? maintenanceMessage = freezed,
    Object? customSettings = null,
  }) {
    return _then(_$AdminSettingsImpl(
      enableUserRegistration: null == enableUserRegistration
          ? _value.enableUserRegistration
          : enableUserRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
      requireEmailVerification: null == requireEmailVerification
          ? _value.requireEmailVerification
          : requireEmailVerification // ignore: cast_nullable_to_non_nullable
              as bool,
      maxLoginAttempts: null == maxLoginAttempts
          ? _value.maxLoginAttempts
          : maxLoginAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      sessionTimeout: null == sessionTimeout
          ? _value.sessionTimeout
          : sessionTimeout // ignore: cast_nullable_to_non_nullable
              as Duration,
      allowedDomains: null == allowedDomains
          ? _value._allowedDomains
          : allowedDomains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maintenanceMode: null == maintenanceMode
          ? _value.maintenanceMode
          : maintenanceMode // ignore: cast_nullable_to_non_nullable
              as bool,
      maintenanceMessage: freezed == maintenanceMessage
          ? _value.maintenanceMessage
          : maintenanceMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      customSettings: null == customSettings
          ? _value._customSettings
          : customSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminSettingsImpl implements _AdminSettings {
  const _$AdminSettingsImpl(
      {required this.enableUserRegistration,
      required this.requireEmailVerification,
      required this.maxLoginAttempts,
      required this.sessionTimeout,
      required final List<String> allowedDomains,
      this.maintenanceMode = false,
      this.maintenanceMessage,
      final Map<String, dynamic> customSettings = const {}})
      : _allowedDomains = allowedDomains,
        _customSettings = customSettings;

  factory _$AdminSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminSettingsImplFromJson(json);

  @override
  final bool enableUserRegistration;
  @override
  final bool requireEmailVerification;
  @override
  final int maxLoginAttempts;
  @override
  final Duration sessionTimeout;
  final List<String> _allowedDomains;
  @override
  List<String> get allowedDomains {
    if (_allowedDomains is EqualUnmodifiableListView) return _allowedDomains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedDomains);
  }

  @override
  @JsonKey()
  final bool maintenanceMode;
  @override
  final String? maintenanceMessage;
  final Map<String, dynamic> _customSettings;
  @override
  @JsonKey()
  Map<String, dynamic> get customSettings {
    if (_customSettings is EqualUnmodifiableMapView) return _customSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customSettings);
  }

  @override
  String toString() {
    return 'AdminSettings(enableUserRegistration: $enableUserRegistration, requireEmailVerification: $requireEmailVerification, maxLoginAttempts: $maxLoginAttempts, sessionTimeout: $sessionTimeout, allowedDomains: $allowedDomains, maintenanceMode: $maintenanceMode, maintenanceMessage: $maintenanceMessage, customSettings: $customSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSettingsImpl &&
            (identical(other.enableUserRegistration, enableUserRegistration) ||
                other.enableUserRegistration == enableUserRegistration) &&
            (identical(
                    other.requireEmailVerification, requireEmailVerification) ||
                other.requireEmailVerification == requireEmailVerification) &&
            (identical(other.maxLoginAttempts, maxLoginAttempts) ||
                other.maxLoginAttempts == maxLoginAttempts) &&
            (identical(other.sessionTimeout, sessionTimeout) ||
                other.sessionTimeout == sessionTimeout) &&
            const DeepCollectionEquality()
                .equals(other._allowedDomains, _allowedDomains) &&
            (identical(other.maintenanceMode, maintenanceMode) ||
                other.maintenanceMode == maintenanceMode) &&
            (identical(other.maintenanceMessage, maintenanceMessage) ||
                other.maintenanceMessage == maintenanceMessage) &&
            const DeepCollectionEquality()
                .equals(other._customSettings, _customSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      enableUserRegistration,
      requireEmailVerification,
      maxLoginAttempts,
      sessionTimeout,
      const DeepCollectionEquality().hash(_allowedDomains),
      maintenanceMode,
      maintenanceMessage,
      const DeepCollectionEquality().hash(_customSettings));

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSettingsImplCopyWith<_$AdminSettingsImpl> get copyWith =>
      __$$AdminSettingsImplCopyWithImpl<_$AdminSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminSettingsImplToJson(
      this,
    );
  }
}

abstract class _AdminSettings implements AdminSettings {
  const factory _AdminSettings(
      {required final bool enableUserRegistration,
      required final bool requireEmailVerification,
      required final int maxLoginAttempts,
      required final Duration sessionTimeout,
      required final List<String> allowedDomains,
      final bool maintenanceMode,
      final String? maintenanceMessage,
      final Map<String, dynamic> customSettings}) = _$AdminSettingsImpl;

  factory _AdminSettings.fromJson(Map<String, dynamic> json) =
      _$AdminSettingsImpl.fromJson;

  @override
  bool get enableUserRegistration;
  @override
  bool get requireEmailVerification;
  @override
  int get maxLoginAttempts;
  @override
  Duration get sessionTimeout;
  @override
  List<String> get allowedDomains;
  @override
  bool get maintenanceMode;
  @override
  String? get maintenanceMessage;
  @override
  Map<String, dynamic> get customSettings;

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSettingsImplCopyWith<_$AdminSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

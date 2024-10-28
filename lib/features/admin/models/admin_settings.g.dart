// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminSettingsImpl _$$AdminSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AdminSettingsImpl(
      enableUserRegistration: json['enableUserRegistration'] as bool,
      requireEmailVerification: json['requireEmailVerification'] as bool,
      maxLoginAttempts: (json['maxLoginAttempts'] as num).toInt(),
      sessionTimeout:
          Duration(microseconds: (json['sessionTimeout'] as num).toInt()),
      allowedDomains: (json['allowedDomains'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maintenanceMode: json['maintenanceMode'] as bool? ?? false,
      maintenanceMessage: json['maintenanceMessage'] as String?,
      customSettings:
          json['customSettings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AdminSettingsImplToJson(_$AdminSettingsImpl instance) =>
    <String, dynamic>{
      'enableUserRegistration': instance.enableUserRegistration,
      'requireEmailVerification': instance.requireEmailVerification,
      'maxLoginAttempts': instance.maxLoginAttempts,
      'sessionTimeout': instance.sessionTimeout.inMicroseconds,
      'allowedDomains': instance.allowedDomains,
      'maintenanceMode': instance.maintenanceMode,
      'maintenanceMessage': instance.maintenanceMessage,
      'customSettings': instance.customSettings,
    };

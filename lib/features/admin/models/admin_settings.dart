import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_settings.freezed.dart';
part 'admin_settings.g.dart';

@freezed
class AdminSettings with _$AdminSettings {
  const factory AdminSettings({
    required bool enableUserRegistration,
    required bool requireEmailVerification,
    required int maxLoginAttempts,
    required Duration sessionTimeout,
    required List<String> allowedDomains,
    @Default(false) bool maintenanceMode,
    String? maintenanceMessage,
    @Default({}) Map<String, dynamic> customSettings,
  }) = _AdminSettings;

  factory AdminSettings.fromJson(Map<String, dynamic> json) =>
      _$AdminSettingsFromJson(json);

  factory AdminSettings.defaults() => const AdminSettings(
        enableUserRegistration: true,
        requireEmailVerification: true,
        maxLoginAttempts: 5,
        sessionTimeout: Duration(hours: 24),
        allowedDomains: [],
      );
}

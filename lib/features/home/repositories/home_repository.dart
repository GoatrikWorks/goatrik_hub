import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../enums/activity_enums.dart';
import '../models/activity.dart';

class HomeRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  HomeRepository({
    ApiClient? apiClient,
    bool useMockData = false,
  })  : _apiClient = apiClient ?? DioApiClient(),
        _useMockData = useMockData;

  Future<List<Activity>> getActivities() async {
    if (_useMockData) {
      return _getActivitiesWithMockData();
    }

    try {
      final response = await _apiClient.get(ApiEndpoints.activities);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Activity.fromJson(json)).toList();
      } else {
        throw Exception(
            'Misslyckades att hämta aktiviteter (${response.statusCode})');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Kunde inte hämta aktiviteter');
    } catch (e) {
      throw Exception(
          'Ett oväntat fel inträffade vid hämtning av aktiviteter: $e');
    }
  }

  Future<Activity> createActivity(Activity activity) async {
    if (_useMockData) {
      return _createMockActivity(activity);
    }

    try {
      final response = await _apiClient.post(
        ApiEndpoints.activities,
        data: activity.toJson(),
      );

      if (response.statusCode == 201) {
        return Activity.fromJson(response.data);
      } else {
        throw Exception(
            'Misslyckades att skapa aktivitet (${response.statusCode})');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Kunde inte skapa aktivitet');
    } catch (e) {
      throw Exception(
          'Ett oväntat fel inträffade vid skapande av aktivitet: $e');
    }
  }

  Future<Activity> updateActivity(Activity activity) async {
    if (_useMockData) {
      return _updateMockActivity(activity);
    }

    try {
      final response = await _apiClient.put(
        ApiEndpoints.activityDetail(activity.id),
        data: activity.toJson(),
      );

      if (response.statusCode == 200) {
        return Activity.fromJson(response.data);
      } else {
        throw Exception(
            'Misslyckades att uppdatera aktivitet (${response.statusCode})');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Kunde inte uppdatera aktivitet');
    } catch (e) {
      throw Exception(
          'Ett oväntat fel inträffade vid uppdatering av aktivitet: $e');
    }
  }

  Future<void> deleteActivity(String id) async {
    if (_useMockData) {
      return _deleteMockActivity(id);
    }

    try {
      final response = await _apiClient.delete(
        ApiEndpoints.activityDetail(id),
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception(
            'Misslyckades att radera aktivitet (${response.statusCode})');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Kunde inte radera aktivitet');
    } catch (e) {
      throw Exception(
          'Ett oväntat fel inträffade vid radering av aktivitet: $e');
    }
  }

  Exception _handleDioError(DioException error, String defaultMessage) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Anslutningen tog för lång tid');
      case DioExceptionType.sendTimeout:
        return Exception('Kunde inte skicka data till servern');
      case DioExceptionType.receiveTimeout:
        return Exception('Servern svarade inte i tid');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? defaultMessage;
        return Exception('$message (Statuskod: $statusCode)');
      case DioExceptionType.cancel:
        return Exception('Förfrågan avbröts');
      case DioExceptionType.connectionError:
        return Exception(
            'Kunde inte ansluta till servern. Kontrollera din internetanslutning.');
      case DioExceptionType.badCertificate:
        return Exception('Säkerhetsfel: Ogiltigt certifikat');
      case DioExceptionType.unknown:
        if (error.error != null) {
          return Exception('Ett fel uppstod: ${error.error}');
        }
        return Exception(defaultMessage);
    }
  }

  // Mock data implementation
  final List<Activity> _mockActivities = [
    Activity(
      id: '1',
      title: 'Testaktivitet 1',
      description: 'Detta är en testaktivitet',
      createdAt: DateTime.now(),
      type: ActivityType.task,
      status: ActivityStatus.pending,
      priority: ActivityPriority.medium,
    ),
    Activity(
      id: '2',
      title: 'Testaktivitet 2',
      description: 'Detta är en annan testaktivitet',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: ActivityType.event,
      status: ActivityStatus.completed,
      priority: ActivityPriority.high,
    ),
  ];

  Future<List<Activity>> _getActivitiesWithMockData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.from(_mockActivities);
  }

  Future<Activity> _createMockActivity(Activity activity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockActivities.add(activity);
    return activity;
  }

  Future<Activity> _updateMockActivity(Activity updatedActivity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockActivities.indexWhere((a) => a.id == updatedActivity.id);
    if (index == -1) {
      throw Exception('Aktivitet hittades inte');
    }
    _mockActivities[index] = updatedActivity;
    return updatedActivity;
  }

  Future<void> _deleteMockActivity(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockActivities.indexWhere((a) => a.id == id);
    if (index == -1) {
      throw Exception('Aktivitet hittades inte');
    }
    _mockActivities.removeAt(index);
  }

  // Development helpers
  bool get useMockData => _useMockData;
  List<Activity> get mockActivities => List.unmodifiable(_mockActivities);

  void clearMockData() {
    _mockActivities.clear();
  }

  void addMockActivity(Activity activity) {
    _mockActivities.add(activity);
  }
}

class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';

  // User endpoints
  static const String profile = '/user/profile';

  // Activity endpoints
  static const String activities = '/activities';
  static String activityDetail(String id) => '/activities/$id';
}

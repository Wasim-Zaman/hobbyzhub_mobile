abstract class AppUrl {
  static const String testBaseUrl = "http://127.0.0.1:8000/api";
  static const String liveBaseUrl = "http://149.28.232.132:8765";
  static const String accountManagementService = "/accountmanagement-service/";
  static const String baseUrl = liveBaseUrl + accountManagementService;
}

abstract class AuthUrl {
  static const String register = "${AppUrl.baseUrl}/api/auth/register";
  static const String emailVerification =
      "${AppUrl.baseUrl}/api/auth/verify-account";
  static const String login = "${AppUrl.baseUrl}/api/auth/login";
}

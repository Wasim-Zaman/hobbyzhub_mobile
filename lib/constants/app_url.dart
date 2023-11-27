abstract class AppUrl {
  static const String testBaseUrl = "http://127.0.0.1:8000/api";
  static const String liveUrl = "http://149.28.232.132:8765";
  static const String accountManagementService = "/accountmanagement-service";
  static const String baseUrl = liveUrl + accountManagementService;
}

abstract class AuthUrl {
  static const authService = "/auth-service";
  static const accountService = "/accounts-service";

  static const register = "${AppUrl.liveUrl}$authService/api/v1/auth/register";
  static const sendSignupVerificationEmail =
      "${AppUrl.liveUrl}$accountService/api/v1/accounts/email-otp";
  static const verifyOtp =
      "${AppUrl.liveUrl}$accountService/api/v1/accounts/verify-otp";

  static const String emailVerification =
      "${AppUrl.baseUrl}/api/auth/verify-account";
  static const login = "${AppUrl.liveUrl}$authService/api/v1/auth/login";

  static const String activateAccount =
      "${AppUrl.liveUrl}$authService/api/v1/auth/activate-account";
  static const completeProfile =
      "${AppUrl.liveUrl}$accountService/api/v1/accounts/update-details";
  static const sendVerificationMailForPasswordReset =
      "${AppUrl.liveUrl}$accountService/api/v1/accounts/email-otp";
  static const changePassword =
      "${AppUrl.liveUrl}$authService/api/v1/auth/reset-password";
}

abstract class MediaUrl {
  static const mediaService = "/media-service";
  static String baseUrl = AppUrl.liveUrl + mediaService;
  static final uploadProfilePicture = "$baseUrl/media/profile";
}

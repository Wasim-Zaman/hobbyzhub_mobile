abstract class AppUrl {
  static const String developmentUrl = "http://149.28.232.132:8765";
  static const String productionUrl = "http://149.28.232.132:8765";

  static const String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  // Auth Service
  static const authService = "/auth-service";

  static const register = "${AppUrl.baseUrl}$authService/api/v1/auth/register";
  static const login = "${AppUrl.baseUrl}$authService/api/v1/auth/login";
  static const activateAccount =
      "${AppUrl.baseUrl}$authService/api/v1/auth/activate-account";
  static const changePassword =
      "${AppUrl.baseUrl}$authService/api/v1/auth/reset-password";

  // Account Service
  static const accountService = "/accounts-service";

  static const sendSignupVerificationEmail =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/email-otp?intent=verify-email";
  static const verifyOtp =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/verify-otp";
  static const completeProfile =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/update-details";
  static const sendVerificationMailForPasswordReset =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/email-otp?intent=reset-password";

  // static const String emailVerification =
  //     "${AppUrl.baseUrl}/api/auth/verify-account";
}

abstract class MediaUrl {
  static const mediaService = "/media-service";
  static String baseUrl = AppUrl.productionUrl + mediaService;
  static final uploadProfilePicture = "$baseUrl/media/profile";
}

abstract class PostUrl {
  static const baseUrl = "http://149.28.232.132:8765";
  static const createPost = "$baseUrl/post-service/api/v1/posts/upload";
  static const getPost = "$baseUrl/post-service/api/v1/posts/all";
  static const specficPost = "$baseUrl/post-service/api/v1/posts/post/";
  static const deletepost = "$baseUrl/post-service/api/v1/posts/delete/";
  static const createComment =
      "$baseUrl/post-service/api/v1/comments/comment/create";
  static const createLike = "$baseUrl/post-service/api/likes/create";
}

abstract class MainCategoryUrl {
  static const baseUrl = "${AppUrl.baseUrl}/category-service";

  static const getMainCategories = "$baseUrl/api/v1/categories/hobby/get-list";
  static const getSubCategories =
      "$baseUrl/api/v1/categories/sub-hobby/get-list";
  static const subscribeUserToSubCategory =
      "$baseUrl/api/v1/categories/subscription/subscribe";
}

abstract class SettingUrl {
  static const helpCenterUrl =
      "${AppUrl.baseUrl}/helprequest-service/api/help/get-help";
}

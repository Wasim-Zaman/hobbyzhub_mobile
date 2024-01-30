import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static String developmentUrl = dotenv.env['DEVELOPMENT_URL']!;
  static String productionUrl = dotenv.env['PRODUCTION_URL']!;

  static String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  // Auth Service
  static const authService = "/auth-service";

  static final register = "${AppUrl.baseUrl}$authService/api/v1/auth/register";
  static final login = "${AppUrl.baseUrl}$authService/api/v1/auth/login";
  static final activateAccount =
      "${AppUrl.baseUrl}$authService/api/v1/auth/activate-account";
  static final changePassword =
      "${AppUrl.baseUrl}$authService/api/v1/auth/reset-password";

  // Account Service
  static const accountService = "/accounts-service";

  static final sendSignupVerificationEmail =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/email-otp?intent=verify-email";
  static final verifyOtp =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/verify-otp";
  static final completeProfile =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/update-details";
  static final sendVerificationMailForPasswordReset =
      "${AppUrl.baseUrl}$accountService/api/v1/accounts/email-otp?intent=reset-password";
  static final searchUserByName =
      '${AppUrl.baseUrl}$accountService/api/v1/accounts/search';
  // static final String emailVerification =
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

abstract class CategoryUrl {
  static final baseUrl = "${AppUrl.baseUrl}/category-service";

  // Main Categories URL
  static final getMainCategories = "$baseUrl/api/v1/categories/hobby/get-list";
  static final searchCategoriesBySlug =
      "$baseUrl/api/v1/categories/hobby/search";

  // Sub-Categories URL
  static final getSubCategories =
      "$baseUrl/api/v1/categories/sub-hobby/get-list";
  static final subscribeUserToSubCategory =
      "$baseUrl/api/v1/categories/subscription/subscribe";
}

abstract class SettingUrl {
  static const helpCenterUrl =
      "http://149.28.232.132:8765/helprequest-service/api/help/get-help";
}

abstract class FollowersUrl {
  static final baseUrl = '${AppUrl.baseUrl}/follower-service';

  static final getMyFollowers = '$baseUrl/api/v1/follower/get';
  static final getOtherFollowers = '$baseUrl/api/v1/follower/get-third';
  static final getMyFollowings = '$baseUrl/api/v1/following/get';
  static final getOtherFollowings = '$baseUrl/api/v1/following/get-third';
  static final getCount = '$baseUrl/api/v1/follower/count';
  static final followUnfollow =
      '$baseUrl/api/v1/user-relationship/follow-unfollow';
  static final checkFollowing =
      '$baseUrl/api/v1/user-relationship/check-following';
}

abstract class UserProfileUrl {
  static final userProfileUrl =
      "${AppUrl.baseUrl}/accounts-service/api/v1/accounts/get-details";
  static final userPostsUrl =
      "${AppUrl.baseUrl}/post-service/api/v1/posts/user-posts";
}

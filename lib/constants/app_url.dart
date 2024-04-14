import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static String developmentUrl = dotenv.env['DEVELOPMENT_URL']!;
  static String productionUrl = dotenv.env['PRODUCTION_URL']!;

  static String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  // Auth Service
  static final authBase = AppUrl.baseUrl;

  static final register = "$authBase/api/v1/auth/register";
  static final login = "$authBase/api/v1/auth/login";
  static final activateAccount = "$authBase/api/v1/auth/activate-account";
  static final changePassword = "$authBase/api/v1/auth/reset-password";
  static final refreshToken = "$authBase/api/v1/accounts/refresh-token";
  static final fcmToken = "$authBase/api/v1/accounts/firebase-token";
  static final logout = "$authBase/api/v1/auth/logout";

  // Account Service

  static final accountBase = AppUrl.baseUrl;

  static final sendSignupVerificationEmail =
      "$accountBase/api/v1/accounts/email-otp?intent=verify-email";
  static final verifyOtp = "$accountBase/api/v1/accounts/verify-otp";
  static final completeProfile = "$accountBase/api/v1/accounts/update-details";
  static final sendVerificationMailForPasswordReset =
      "$accountBase/api/v1/accounts/email-otp?intent=reset-password";
  static final searchUserByName = '$accountBase/api/v1/accounts/search';
  // static final String emailVerification =
  //     "${AppUrl.baseUrl}/api/auth/verify-account";
}

abstract class ChatUrl {
  static final chatBase = AppUrl.baseUrl;

  static final searchUsersByName = "$chatBase/api/v1/accounts/search";
  static final createPrivateChat = "$chatBase/api/chats/private/create-chat";
  static final createGroupChat = "$chatBase/api/chats/group/create-chat";
  static final sendMessage = "$chatBase/api/chats/send-message";
  static final getChats = "$chatBase/api/v1/chats/private/get-chats";
  static final getMessages = "$chatBase/api/chats/messages";
  static final getUsers = "$chatBase/api/v1/chat/usersNotChatted";
  static final createConversation = "$chatBase/api/v1/chat/createConversation";
  static final makeMemberAdmin = "$chatBase/api/v1/chat/makeMemberAdmin";
  static final removeMember = "$chatBase/api/v1/chat/removeMember";
  static final addMember = "$chatBase/api/v1/chat/addMember";
}

abstract class MediaUrl {
  static String baseUrl = AppUrl.productionUrl;
  static final uploadProfilePicture = "$baseUrl/media/profile";
}

abstract class PostUrl {
  static String baseUrl = AppUrl.baseUrl;
  static final createPost = "$baseUrl/api/v1/posts/upload";
  static final getPost = "$baseUrl/api/v1/posts/all";
  static final specficPost = "$baseUrl/api/v1/posts/post/";
  static final deletepost = "$baseUrl/api/v1/posts/delete/";
  static final createComment = "$baseUrl/api/v1/comments/comment/create";
  static final createLike = "$baseUrl/api/likes/create";
  static final createUnLike = "$baseUrl/api/likes/unlike";
  static final createStory = "$baseUrl/api/stories/upload";
  static final getStory = "$baseUrl/api/stories/view/all";
}

abstract class CategoryUrl {
  static final baseUrl = AppUrl.baseUrl;

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
  static String baseUrl = AppUrl.baseUrl;
  static final helpCenterUrl = "$baseUrl/helprequest-service/api/help/get-help";
}

abstract class FollowersUrl {
  static String baseUrl = AppUrl.baseUrl;

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
  static final userProfileUrl = "${AppUrl.baseUrl}/api/v1/accounts/get-details";
  static final userPostsUrl = "${AppUrl.baseUrl}/api/v1/posts/user-posts";
}

abstract class GroupUrl {
  static final groupBase = AppUrl.baseUrl;

  static final createMedia = "$groupBase/api/v1/chats/media/upload";
  static final createGroup = "$groupBase/api/v1/chats/groups/create";
  static final getChats = "$groupBase/api/v1/chats/groups/get-for-user";
  static final groupDetails = "$groupBase/api/v1/chats/groups/get-group";
  static final addMember = "$groupBase/api/v1/chats/groups/add-member";
}

abstract class ExploreUrl {
  static final baseUrl = AppUrl.baseUrl;

  static final getRandomUsers = "$baseUrl/api/v1/accounts/users/shuffled";
  static final getRandomPosts = "$baseUrl/api/v1/posts/shuffled";
  static final getHobbyz = "$baseUrl/api/v1/categories/hobby/subscribers";
  static final getPostsByHobby =
      "$baseUrl/api/v1/categories/hobby/get-category";
}

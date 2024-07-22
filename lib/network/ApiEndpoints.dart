// ignore_for_file: file_names

class ApiEndpoints {
  //static const String baseUrl = "http://192.168.1.13:3000";
  static const String baseUrl = "https://dev.gvlive.ph/api/v1";
  // static const String baseUrl = "https://dev.gvlive.ph/api/v1";

  static const String login = "$baseUrl/signin/email";
  // static const String login = "$baseUrl/signin/email";
  static const String unsynced = "$baseUrl/unsynced";

  static const String saveFund = "$baseUrl/funds";
  static const String saveTransaction = "$baseUrl/transactions";
  static const String saveAdmin = "$baseUrl/admins/create";
  static const String saveSuperAdmin = "$baseUrl/super-admins/create";
  static const String saveUser = "$baseUrl/users";

  static const String verifyemail = "$baseUrl/signup/email";
  static const String sendotp = "$baseUrl/signup/resend-otp-email";
  static const String verifyotp = "$baseUrl/signup/verify-otp-email";
  static const String setpassword = "$baseUrl/signup/password";
  static const String refreshToken = "$baseUrl/signin/refresh-token";
  static const String forgotpassword1 =
      "$baseUrl/signin/email/forgot-password-step-1";
  static const String forgotpassword2 =
      "$baseUrl/signin/email/forgot-password-step-2";
  static const String forgotpassword3 =
      "$baseUrl/signin/email/forgot-password-step-3";

  static const String updateprofile = "$baseUrl/users/me";

/*   static const String verifyemail = "$baseUrl/signup/email";
  static const String sendotp = "$baseUrl/signup/resend-otp-email";
  static const String verifyotp = "$baseUrl/signup/verify-otp-email";
  static const String setpassword = "$baseUrl/signup/password";
  static const String refreshToken = "$baseUrl/signin/refresh-token";
  static const String forgotpassword1 = "$baseUrl/signin/email/forgot-password-step-1";
  static const String forgotpassword2 = "$baseUrl/signin/email/forgot-password-step-2";
  static const String forgotpassword3 = "$baseUrl/signin/email/forgot-password-step-3"; */

  static const String preferredContent = "$baseUrl/preferred-content";
  static const String interests = "$baseUrl/interests";
  static const String chooseInterests = "$baseUrl/users/interests/choose";

  static const String createPosts = "$baseUrl/posts";
  static const String postsDetails = "$baseUrl/posts";
  static const String deletePosts = "$baseUrl/posts";
  static const String editPosts = "$baseUrl/posts";
  static const String getPostsViews = "$baseUrl/posts";
  static const String getPostsPosts = "$baseUrl/posts";

  static const String postsForYou = "$baseUrl/posts/for-you";
  static const String postsFollowing = "$baseUrl/posts/following";
  static const String suggestToFololw = "$baseUrl/users/me/suggest-to-follow";
  static const String usersFollowing = "$baseUrl/users/me/following";
  static const String usersFollowers = "$baseUrl/users/me/followers";
  static const String followUser = "$baseUrl/users";
  static const String removeUser = "$baseUrl/users";
  static const String unfollowUser = "$baseUrl/users";
}

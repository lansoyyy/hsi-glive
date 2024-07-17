class ApiEndpoints {
  //static const String baseUrl = "http://192.168.1.13:3000";
  static const String baseUrl = "https://dev.gvlive.ph/api/v1";

  static const String login = "$baseUrl/signin/email";
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
}

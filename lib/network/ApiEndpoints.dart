// ignore_for_file: file_names

class ApiEndpoints {
  //static const String baseUrl = "http://192.168.1.13:3000";
  static const String baseUrl = "https://ksmiguel.com";

  static const String login = "$baseUrl/glive/login.php";
  static const String unsynced = "$baseUrl/unsynced";

  static const String saveFund = "$baseUrl/funds";
  static const String saveTransaction = "$baseUrl/transactions";
  static const String saveAdmin = "$baseUrl/admins/create";
  static const String saveSuperAdmin = "$baseUrl/super-admins/create";
  static const String saveUser = "$baseUrl/users";
}

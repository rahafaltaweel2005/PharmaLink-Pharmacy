class ApiConst {
  static const String baseUrl = "http://192.168.1.101:5279";

  static const String login = "/api/Auth/login";
  static const String register = "/api/Auth/register";
  static const String refreshToken = "/api/Auth/refresh-token";
  static const String logout = "/api/Auth/logout";

  static const String medicine = "/api/Medicine";
  static String medicineById(int id) => "/api/Medicine/$id";

  static const String pharmacyInventory = "/api/Inventory/pharmacy-inventory";
}

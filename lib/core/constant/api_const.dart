class ApiConst {
  static const String baseUrl = "http://192.168.1.144:5279";

  static const String login = "/api/Auth/login";
  static const String register = "/api/Auth/register";
  static const String refreshToken = "/api/Auth/refresh-token";
  static const String logout = "/api/Auth/logout";

  static const String medicine = "/api/Medicine";
  static String medicineById(int id) => "/api/Medicine/$id";

  static const String createOrder = "/api/Order";
  static String order(int id) => "/api/Order/$id";
  static const String pharmacyOrder = "/api/Order/pharmacy-orders";

  static const String pharmacyInventory = "/api/Inventory/pharmacy-inventory";
}

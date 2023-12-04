class Apis {
  /// Live Mode
  static const String baseUrl = "http://62.72.44.247/api";

  static const String baseUrlForMedia = "http://62.72.44.247";

  static headers({required String token}) =>
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

  static headersNoAuth() => {'Content-Type': 'application/json'};

  ////Endpoints
  ///Auth
  static const String login = "/auth/login";
  static const String register = "/users";
  static const String categories = "/products/categories";
  static const String products = "/products/";
  static const String customers = "/customers/";

  static String updateCustomer({required int customerId}) =>
      "/customers/?id=$customerId";
  static const String orders = "/orders/";

  static String productsByCategory({required String category}) =>
      "/products/category/$category";
}

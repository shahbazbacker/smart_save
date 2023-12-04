class Order {
  final int errorCode;
  final Data data;
  final String message;

  Order({
    required this.errorCode,
    required this.data,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

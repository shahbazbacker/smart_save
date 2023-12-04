import 'dart:convert';

import 'package:smart_save/features/home/domain/entities/order.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel extends Order {
  OrderModel({
    required super.errorCode,
    required super.data,
    required super.message,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        errorCode: json["error_code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data.toJson(),
        "message": message,
      };
}

class DataModel extends Data {
  DataModel();

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel();

  @override
  Map<String, dynamic> toJson() => {};
}

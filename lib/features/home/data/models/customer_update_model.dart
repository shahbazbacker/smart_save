import 'dart:convert';

import '../../domain/entities/customer_update.dart';
import 'customer_model.dart';

CustomerUpdateResultModel customerUpdateResultModelFromJson(String str) =>
    CustomerUpdateResultModel.fromJson(json.decode(str));

String customerUpdateResultModelToJson(CustomerUpdateResultModel data) =>
    json.encode(data.toJson());

class CustomerUpdateResultModel extends CustomerUpdateResult {
  const CustomerUpdateResultModel({
    required super.errorCode,
    required super.customer,
    required super.message,
  });

  factory CustomerUpdateResultModel.fromJson(Map<String, dynamic> json) =>
      CustomerUpdateResultModel(
        errorCode: json["error_code"],
        customer: CustomerModel.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": customer.toJson(),
        "message": message,
      };
}

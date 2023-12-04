import 'dart:convert';

import '../../domain/entities/customer_create.dart';
import 'customer_model.dart';

CustomerCreateResultModel customerCreateResultModelFromJson(String str) =>
    CustomerCreateResultModel.fromJson(json.decode(str));

String customerCreateResultModelToJson(CustomerCreateResultModel data) =>
    json.encode(data.toJson());

class CustomerCreateResultModel extends CustomerCreateResult {
  const CustomerCreateResultModel({
    required super.errorCode,
    required super.customer,
    required super.message,
  });

  factory CustomerCreateResultModel.fromJson(Map<String, dynamic> json) =>
      CustomerCreateResultModel(
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

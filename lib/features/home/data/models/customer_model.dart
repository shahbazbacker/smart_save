import 'dart:convert';

import 'package:smart_save/features/home/domain/entities/customer.dart';

CustomerResultModel customerResultModelFromJson(String str) =>
    CustomerResultModel.fromJson(json.decode(str));

String customerResultModelToJson(CustomerResultModel data) =>
    json.encode(data.toJson());

class CustomerResultModel extends CustomerResult {
  CustomerResultModel({
    required super.errorCode,
    required super.customers,
    required super.message,
  });

  factory CustomerResultModel.fromJson(Map<String, dynamic> json) =>
      CustomerResultModel(
        errorCode: json["error_code"],
        customers: List<CustomerModel>.from(
            json["data"].map((x) => CustomerModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": List<dynamic>.from(customers.map((x) => x.toJson())),
        "message": message,
      };
}

class CustomerModel extends Customer {
  CustomerModel({
    required super.id,
    required super.name,
    required super.profilePic,
    required super.mobileNumber,
    required super.email,
    required super.street,
    required super.streetTwo,
    required super.city,
    required super.pinCode,
    required super.country,
    required super.state,
    required super.createdDate,
    required super.createdTime,
    required super.modifiedDate,
    required super.modifiedTime,
    required super.flag,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        name: json["name"],
        profilePic: json["profile_pic"] ?? '',
        mobileNumber: json["mobile_number"],
        email: json["email"],
        street: json["street"],
        streetTwo: json["street_two"],
        city: json["city"],
        pinCode: json["pincode"],
        country: json["country"],
        state: json["state"],
        createdDate: DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_pic": profilePic,
        "mobile_number": mobileNumber,
        "email": email,
        "street": street,
        "street_two": streetTwo,
        "city": city,
        "pincode": pinCode,
        "country": country,
        "state": state,
        "created_date":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate.year.toString().padLeft(4, '0')}-${modifiedDate.month.toString().padLeft(2, '0')}-${modifiedDate.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };
}

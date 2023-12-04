import 'dart:convert';

import 'package:smart_save/features/home/domain/entities/product.dart';

ProductResultModel productResultModelFromJson(String str) =>
    ProductResultModel.fromJson(json.decode(str));

String productResultModelToJson(ProductResultModel data) =>
    json.encode(data.toJson());

class ProductResultModel extends ProductResult {
  const ProductResultModel({
    required super.errorCode,
    required super.products,
    required super.message,
  });

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
        errorCode: json["error_code"],
        products: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": List<dynamic>.from(products.map((x) => x.toJson())),
        "message": message,
      };
}

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.image,
    required super.price,
    required super.createdDate,
    required super.createdTime,
    required super.modifiedDate,
    required super.modifiedTime,
    required super.flag,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );
}

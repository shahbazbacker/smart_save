import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../configs/colors.dart';
import '../../features/home/domain/entities/customer.dart';
import '../../features/home/domain/entities/customer_hive_model.dart';
import '../../features/home/domain/entities/product.dart';
import '../../features/home/domain/entities/product_hive_model.dart';

extension ProductExtension on Product {
  ProductHiveModel toProductHiveModel() {
    return ProductHiveModel(
        id: id,
        name: name,
        image: image,
        price: price,
        createdDate: createdDate,
        createdTime: createdTime,
        modifiedDate: modifiedDate,
        modifiedTime: modifiedTime,
        flag: flag,
        quantity: quantity,
        totalPrice: totalPrice);
  }
}

extension ProductHiveModelExtension on ProductHiveModel {
  Product toProductModel() {
    return Product(
        id: id,
        name: name,
        image: image,
        price: price,
        createdDate: createdDate,
        createdTime: createdTime,
        modifiedDate: modifiedDate,
        modifiedTime: modifiedTime,
        flag: flag,
        totalPrice: totalPrice,
        quantity: quantity);
  }
}

// Extension methods for converting lists of Product to ProductHiveModel and vice versa
extension ProductListExtension on List<Product> {
  List<ProductHiveModel> toProductHiveModelList() {
    return map((product) => product.toProductHiveModel()).toList();
  }
}

extension ProductHiveModelListExtension on List<ProductHiveModel> {
  List<Product> toProductModelList() {
    return map((hiveModel) => hiveModel.toProductModel()).toList();
  }
}

// Extension methods for converting Customer to CustomerHiveModel and vice versa
extension CustomerExtension on Customer {
  CustomerHiveModel toCustomerHiveModel() {
    return CustomerHiveModel(
      id: id,
      name: name,
      profilePic: profilePic,
      mobileNumber: mobileNumber,
      email: email,
      street: street,
      streetTwo: streetTwo,
      city: city,
      pinCode: pinCode,
      country: country,
      state: state,
      createdDate: createdDate,
      createdTime: createdTime,
      modifiedDate: modifiedDate,
      modifiedTime: modifiedTime,
      flag: flag,
      isSelected: isSelected,
    );
  }
}

extension CustomerHiveModelExtension on CustomerHiveModel {
  Customer toCustomerModel() {
    return Customer(
      id: id,
      name: name,
      profilePic: profilePic,
      mobileNumber: mobileNumber,
      email: email,
      street: street,
      streetTwo: streetTwo,
      city: city,
      pinCode: pinCode,
      country: country,
      state: state,
      createdDate: createdDate,
      createdTime: createdTime,
      modifiedDate: modifiedDate,
      modifiedTime: modifiedTime,
      flag: flag,
      isSelected: isSelected,
    );
  }
}

// Extension methods for converting lists of Customer to CustomerHiveModel and vice versa
extension CustomerListExtension on List<Customer> {
  List<CustomerHiveModel> toCustomerHiveModelList() {
    return map((customer) => customer.toCustomerHiveModel()).toList();
  }
}

extension CustomerHiveModelListExtension on List<CustomerHiveModel> {
  List<Customer> toCustomerModelList() {
    return map((hiveModel) => hiveModel.toCustomerModel()).toList();
  }
}

extension StringSnackbarExtension on String {
  showSnack() => showToast(this,
      backgroundColor: AppColors.black600,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0));
}

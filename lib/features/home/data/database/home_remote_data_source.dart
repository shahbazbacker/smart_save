import 'dart:convert';
import 'dart:developer';

import 'package:smart_save/features/home/data/models/customer_create_model.dart';
import 'package:smart_save/features/home/domain/entities/cart.dart';
import 'package:smart_save/features/home/domain/entities/customer_create.dart';
import 'package:smart_save/features/home/domain/entities/order.dart';
import 'package:smart_save/features/home/domain/entities/product.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_support.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/customer_update.dart';
import '../models/create_order_model.dart';
import '../models/customer_model.dart';
import '../models/customer_update_model.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  Future<ProductResult> getProducts();
  Future<CustomerResult> getCustomers();
  Future<CustomerCreateResult> registerUser({
    required String name,
    required String mobile,
    required String email,
    required String street,
    required String streetTwo,
    required String pinCode,
    required String city,
    required String country,
    required String state,
  });

  Future<CustomerUpdateResult> updateUser({
    required int customerId,
    required String name,
    required String mobile,
    required String email,
    required String street,
    required String streetTwo,
    required String pinCode,
    required String city,
    required String country,
    required String state,
  });

  Future<Order> createOrder(
      {required CartItem cartItem,
      required int totalPrice,
      required Customer customer});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<ProductResultModel> getProducts() async {
    final url = Uri.parse(Apis.baseUrl + Apis.products);

    final response = await _client.get(
      url,
      headers: Apis.headersNoAuth(),
    );
    log("Request url: ${url.toString()}");
    log("Response body: ${response.body.toString()}");
    log("Response code: ${response.statusCode}");

    if (response.statusCode == 401) {
      throw APIException(
          message: response.body, statusCode: response.statusCode);
    }
    return productResultModelFromJson(response.body);
  }

  @override
  Future<CustomerResult> getCustomers() async {
    final url = Uri.parse(Apis.baseUrl + Apis.customers);

    final response = await _client.get(
      url,
      headers: Apis.headersNoAuth(),
    );
    log("Request url: ${url.toString()}");
    log("Response body: ${response.body.toString()}");
    log("Response code: ${response.statusCode}");

    if (response.statusCode == 401) {
      throw APIException(
          message: response.body, statusCode: response.statusCode);
    }
    return customerResultModelFromJson(response.body);
  }

  @override
  Future<CustomerCreateResult> registerUser(
      {required String name,
      required String mobile,
      required String email,
      required String street,
      required String streetTwo,
      required String pinCode,
      required String city,
      required String country,
      required String state}) async {
    final url = Uri.parse(Apis.baseUrl + Apis.customers);

    final body = jsonEncode({
      "name": name,
      "profile_pic": "",
      "email": email,
      "mobile_number": mobile,
      "street": street,
      "street_two": streetTwo,
      "city": city,
      "pincode": int.parse(pinCode),
      "country": country,
      "state": state
    });
    final response = await _client.post(
      url,
      headers: Apis.headersNoAuth(),
      body: body,
    );
    log("Request url: ${url.toString()}");
    log("Request body: ${body.toString()}");
    log("Response body: ${response.body.toString()}");
    log("Response code: ${response.statusCode}");

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw APIException(
          message: response.body, statusCode: response.statusCode);
    }
    return CustomerCreateResultModel.fromJson(json.decode(response.body));
  }

  @override
  Future<CustomerUpdateResult> updateUser({
    required int customerId,
    required String name,
    required String mobile,
    required String email,
    required String street,
    required String streetTwo,
    required String pinCode,
    required String city,
    required String country,
    required String state,
  }) async {
    final url =
        Uri.parse(Apis.baseUrl + Apis.updateCustomer(customerId: customerId));

    final body = jsonEncode({
      "name": name,
      "profile_pic": "",
      "email": email,
      "mobile_number": mobile,
      "street": street,
      "street_two": streetTwo,
      "city": city,
      "pincode": int.parse(pinCode),
      "country": country,
      "state": state
    });
    final response = await _client.put(
      url,
      headers: Apis.headersNoAuth(),
      body: body,
    );
    log("Request url: ${url.toString()}");
    log("Request body: ${body.toString()}");
    log("Response body: ${response.body.toString()}");
    log("Response code: ${response.statusCode}");

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw APIException(
          message: response.body, statusCode: response.statusCode);
    }
    return CustomerUpdateResultModel.fromJson(json.decode(response.body));
  }

  @override
  Future<OrderModel> createOrder(
      {required CartItem cartItem,
      required int totalPrice,
      required Customer customer}) async {
    final url = Uri.parse(Apis.baseUrl + Apis.orders);

    final body = jsonEncode({
      "customer_id": customer.id,
      "total_price": totalPrice,
      "products": List.generate(
          cartItem.products.length,
          (index) => {
                "product_id": cartItem.products[index].id,
                "quantity": cartItem.products[index].quantity,
                "price": cartItem.products[index].price
              })
    });
    final response = await _client.post(
      url,
      headers: Apis.headersNoAuth(),
      body: body,
    );
    log("Request url: ${url.toString()}");
    log("Request body: ${body.toString()}");
    log("Response body: ${response.body.toString()}");
    log("Response code: ${response.statusCode}");

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw APIException(
          message: response.body, statusCode: response.statusCode);
    }
    return OrderModel.fromJson(json.decode(response.body));
  }
}

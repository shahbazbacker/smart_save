import 'package:dartz/dartz.dart';
import 'package:smart_save/features/home/domain/entities/customer.dart';
import 'package:smart_save/features/home/domain/entities/customer_create.dart';
import 'package:smart_save/features/home/domain/entities/order.dart' as order;
import 'package:smart_save/features/home/domain/entities/product.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/customer_update.dart';
import '../../domain/repositories/home_repository.dart';
import '../database/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<ProductResult> getProducts() async {
    try {
      final ProductResult results = await _remoteDataSource.getProducts();
      return Right(results);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CustomerResult> getCustomers() async {
    try {
      final CustomerResult results = await _remoteDataSource.getCustomers();
      return Right(results);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CustomerCreateResult> createCustomer(
      {required String name,
      required String mobile,
      required String email,
      required String street,
      required String streetTwo,
      required String pinCode,
      required String city,
      required String country,
      required String state}) async {
    try {
      final CustomerCreateResult results = await _remoteDataSource.registerUser(
        name: name,
        mobile: mobile,
        email: email,
        street: street,
        streetTwo: streetTwo,
        pinCode: pinCode,
        city: city,
        country: country,
        state: state,
      );
      return Right(results);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CustomerUpdateResult> updateCustomer(
      {required int customerId,
      required String name,
      required String mobile,
      required String email,
      required String street,
      required String streetTwo,
      required String pinCode,
      required String city,
      required String country,
      required String state}) async {
    try {
      final CustomerUpdateResult results = await _remoteDataSource.updateUser(
        customerId: customerId,
        name: name,
        mobile: mobile,
        email: email,
        street: street,
        streetTwo: streetTwo,
        pinCode: pinCode,
        city: city,
        country: country,
        state: state,
      );
      return Right(results);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<order.Order> createOrder(
      {required CartItem cartItem,
      required int totalPrice,
      required Customer customer}) async {
    try {
      final order.Order results = await _remoteDataSource.createOrder(
          cartItem: cartItem, totalPrice: totalPrice, customer: customer);
      return Right(results);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}

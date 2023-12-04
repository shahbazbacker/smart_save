import 'package:smart_save/features/home/domain/entities/customer_create.dart';
import 'package:smart_save/features/home/domain/entities/order.dart';

import '../../../../core/utils/typedef.dart';
import '../entities/cart.dart';
import '../entities/customer.dart';
import '../entities/customer_update.dart';
import '../entities/product.dart';

abstract class HomeRepository {
  ResultFuture<ProductResult> getProducts();
  ResultFuture<CustomerResult> getCustomers();

  ResultFuture<CustomerCreateResult> createCustomer({
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

  ResultFuture<CustomerUpdateResult> updateCustomer({
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

  ResultFuture<Order> createOrder({
    required CartItem cartItem,
    required int totalPrice,
    required Customer customer,
  });
}

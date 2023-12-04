import 'package:equatable/equatable.dart';
import 'package:smart_save/features/home/domain/entities/customer.dart';

import '../../../domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'AddProduct { product: $product }';
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'RemoveProduct { product: $product }';
}

class IncrementProduct extends CartEvent {
  final Product product;

  const IncrementProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'RemoveProduct { product: $product }';
}

class DecrementProduct extends CartEvent {
  final Product product;

  const DecrementProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'RemoveProduct { product: $product }';
}

class ClearCart extends CartEvent {
  const ClearCart();

  @override
  List<Object> get props => [];
}

class GetProductCountInCart extends CartEvent {
  final Product product;

  const GetProductCountInCart({required this.product});

  @override
  List<Object> get props => [product];
}

class AddCustomerToCart extends CartEvent {
  final Customer customer;

  const AddCustomerToCart(this.customer);

  @override
  List<Object> get props => [customer];

  @override
  String toString() => 'Customer in cart { customer: $customer }';
}

class ClearCartAfterOrderEvent extends CartEvent {
  const ClearCartAfterOrderEvent();

  @override
  List<Object> get props => [];
}

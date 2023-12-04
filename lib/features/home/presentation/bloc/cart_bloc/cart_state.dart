import 'package:equatable/equatable.dart';
import 'package:smart_save/features/home/domain/entities/cart.dart';

import '../../../domain/entities/customer.dart';

abstract class CartState extends Equatable {
  CartState(
      {required this.cartItem,
      required this.totalPrice,
      Customer? selectedCustomer})
      : selectedCustomer = selectedCustomer ?? Customer.empty();

  final CartItem cartItem;
  final double totalPrice;
  Customer? selectedCustomer;

  @override
  List<Object> get props => [cartItem, totalPrice];
}

class CartInitial extends CartState {
  CartInitial({required super.cartItem, required super.totalPrice});

  @override
  List<Object> get props => [cartItem.products, totalPrice];

  @override
  String toString() => 'ProductAdded { todos: $cartItem }';
}

class CartLoadInProgress extends CartState {
  CartLoadInProgress({required super.cartItem, required super.totalPrice});
}

class ProductAdded extends CartState {
  ProductAdded(
      {required CartItem cartItem,
      required double totalPrice,
      required Customer selectedCustomer})
      : super(
            cartItem: cartItem,
            totalPrice: totalPrice,
            selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => [cartItem.products, totalPrice];

  @override
  String toString() => 'ProductAdded { todos: $cartItem }';
}

class ProductRemoved extends CartState {
  ProductRemoved(
      {required CartItem cartItem,
      required double totalPrice,
      required Customer selectedCustomer})
      : super(
            cartItem: cartItem,
            totalPrice: totalPrice,
            selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => [cartItem, totalPrice];

  @override
  String toString() => 'ProductRemoved { todos: $cartItem }';
}

class ProductIncremented extends CartState {
  ProductIncremented(
      {required CartItem cartItem,
      required double totalPrice,
      required Customer selectedCustomer})
      : super(
            cartItem: cartItem,
            totalPrice: totalPrice,
            selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => [cartItem, totalPrice];

  @override
  String toString() => 'ProductRemoved { todos: $cartItem }';
}

class ProductDecremented extends CartState {
  ProductDecremented(
      {required CartItem cartItem,
      required double totalPrice,
      required Customer selectedCustomer})
      : super(
            cartItem: cartItem,
            totalPrice: totalPrice,
            selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => [cartItem, totalPrice];

  @override
  String toString() => 'ProductRemoved { todos: $cartItem }';
}

class CartCleared extends CartState {
  CartCleared({required CartItem cartItem, required double totalPrice})
      : super(cartItem: cartItem, totalPrice: totalPrice);

  @override
  List<Object> get props => [cartItem, totalPrice];

  @override
  String toString() => 'ProductAdded { todos: $cartItem }';
}

class GetProductCountInCartState extends CartState {
  final int count;
  final bool isInCart;

  GetProductCountInCartState(
      {required this.count,
      required this.isInCart,
      required super.cartItem,
      required super.totalPrice});

  @override
  List<Object> get props => [count, isInCart];
}

class CartCustomerAddedState extends CartState {
  CartCustomerAddedState(
      {required CartItem cartItem,
      required double totalPrice,
      required Customer selectedCustomer})
      : super(
            cartItem: cartItem,
            totalPrice: totalPrice,
            selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => [cartItem, totalPrice];

  @override
  String toString() => 'ProductRemoved { todos: $cartItem }';
}

class CartClearedAfterOrder extends CartState {
  CartClearedAfterOrder(
      {required CartItem cartItem, required double totalPrice})
      : super(cartItem: cartItem, totalPrice: totalPrice);

  @override
  List<Object> get props => [cartItem, totalPrice];

  @override
  String toString() => 'ProductAdded { todos: $cartItem }';
}

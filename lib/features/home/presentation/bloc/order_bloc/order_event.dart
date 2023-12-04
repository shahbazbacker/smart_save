part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  const CreateOrderEvent({
    required this.cartItem,
    required this.totalPrice,
    required this.customer,
  });

  final CartItem cartItem;
  final int totalPrice;
  final Customer customer;

  @override
  List<Object> get props => [cartItem];

  @override
  String toString() => 'CreateOrder { cartItem: $cartItem }';
}

class SyncOfflineOrdersEvent extends OrderEvent {
  const SyncOfflineOrdersEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Sync Offline Order.';
}

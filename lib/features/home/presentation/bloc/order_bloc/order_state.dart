part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

///Customer Create States
class CreatingOrder extends OrderState {
  const CreatingOrder();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreatedOrderLoaded extends OrderState {
  const CreatedOrderLoaded(this.order);

  final Order order;

  @override
  List<Object> get props => [order];
}

class CreateOrderError extends OrderState {
  const CreateOrderError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

class CreatedOrderInHive extends OrderState {
  const CreatedOrderInHive();

  @override
  List<Object> get props => [];
}

class SyncedAllOfflineOrders extends OrderState {
  const SyncedAllOfflineOrders();

  @override
  List<Object> get props => [];
}

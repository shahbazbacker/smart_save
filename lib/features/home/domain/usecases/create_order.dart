import 'package:equatable/equatable.dart';
import 'package:smart_save/features/home/domain/entities/order.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/cart.dart';
import '../entities/customer.dart';
import '../repositories/home_repository.dart';

class CreateOrderUseCase
    implements UseCaseWithParams<Order, CreateOrderParams> {
  final HomeRepository _repository;

  CreateOrderUseCase(this._repository);

  @override
  ResultFuture<Order> call(CreateOrderParams params) async =>
      _repository.createOrder(
        cartItem: params.cartItem,
        totalPrice: params.totalPrice,
        customer: params.customer,
      );
}

class CreateOrderParams extends Equatable {
  const CreateOrderParams({
    required this.cartItem,
    required this.totalPrice,
    required this.customer,
  });

  final int totalPrice;
  final CartItem cartItem;
  final Customer customer;

  @override
  List<Object> get props => [cartItem, totalPrice];
}

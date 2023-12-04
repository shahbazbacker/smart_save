import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:smart_save/core/utils/extenstions.dart';
import 'package:smart_save/features/home/domain/entities/cart_hive_model.dart';
import 'package:smart_save/features/home/domain/entities/order.dart';

import '../../../domain/entities/cart.dart';
import '../../../domain/entities/customer.dart';
import '../../../domain/entities/customer_hive_model.dart';
import '../../../domain/entities/product_hive_model.dart';
import '../../../domain/usecases/create_order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required CreateOrderUseCase createOrder})
      : _createOrderUseCase = createOrder,
        super(OrderInitial()) {
    on<CreateOrderEvent>(_orderCreateHandler);
    on<SyncOfflineOrdersEvent>(_syncOfflineOrderHandler);
  }

  final CreateOrderUseCase _createOrderUseCase;

  Future<FutureOr<void>> _orderCreateHandler(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(const CreatingOrder());

    ///Checking internet
    bool isInternetAvailable = await InternetConnection().hasInternetAccess;

    if (!isInternetAvailable) {
      log('Internet not available');
      // Try to load data from Hive if there is no internet connection
      // Use Hive to save customers locally
      final Box<CartHiveModel> cartBox = Hive.box<CartHiveModel>('cartBox');
      log(cartBox.length.toString(),
          name: 'cartBox length in _orderCreateHandler');

      // Convert List<Customer> to List<CustomerHiveModel>
      CustomerHiveModel customerToHiveModel =
          event.customer.toCustomerHiveModel();

      // Convert List<Products> to List<ProductHiveModel>
      List<ProductHiveModel> productListToHiveModel =
          event.cartItem.products.toProductHiveModelList();

      // Convert List<Customer> to List<CustomerHiveModel>
      CartHiveModel cartHiveModels = CartHiveModel(
          customer: customerToHiveModel,
          cartList: productListToHiveModel,
          totalPrice: event.totalPrice);

      cartBox.add(cartHiveModels);
      for (int i = 0; i < cartBox.length; i++) {
        log('$i ${cartBox.getAt(i)!.customer.id}');
        for (int j = 0; j < cartBox.getAt(i)!.cartList.length; j++) {
          log(cartBox.getAt(i)!.cartList[j].name);
          log(cartBox.getAt(i)!.cartList[j].quantity.toString());
        }
      }
      log(cartBox.length.toString(), name: 'cartBox length');
      emit(const CreatedOrderInHive());
    } else {
      final result = await _createOrderUseCase(
        CreateOrderParams(
            cartItem: event.cartItem,
            totalPrice: event.totalPrice,
            customer: event.customer),
      );

      result.fold(
        (failure) => emit(CreateOrderError(failure.errorMessage)),
        (success) {
          emit(CreatedOrderLoaded(success));
        },
      );
    }
  }

  Future<void> _syncOfflineOrderHandler(
      SyncOfflineOrdersEvent event, Emitter<OrderState> emit) async {
    log('_syncOfflineOrderHandler hit');
    emit(const CreatingOrder());

    final Box<CartHiveModel> cartBox = Hive.box<CartHiveModel>('cartBox');
    log(cartBox.length.toString(),
        name: 'cartBox.length in _syncOfflineOrderHandler');
    if (cartBox.isNotEmpty) {
      try {
        await Future.wait(
          List.generate(cartBox.length, (index) async {
            log('$index ${cartBox.getAt(index)!.customer.id}');
            log(cartBox.length.toString(), name: 'cartBox length from order');

            final result = await _createOrderUseCase(
              CreateOrderParams(
                cartItem: CartItem(
                  products: cartBox.getAt(index)!.cartList.toProductModelList(),
                ),
                totalPrice: cartBox.getAt(index)!.totalPrice,
                customer: cartBox.getAt(index)!.customer.toCustomerModel(),
              ),
            );

            cartBox.deleteAt(index);

            log(cartBox.length.toString(),
                name:
                    'cartBox.length in _syncOfflineOrderHandler after delete');

            if (index == 0) {
              await cartBox.clear();
            }
            log(cartBox.length.toString(),
                name: 'cartBox.length in _syncOfflineOrderHandler after clear');
            result.fold(
              (failure) {
                emit(const CreateOrderError('An unexpected error occurred'));
              },
              (success) {
                emit(CreatedOrderLoaded(success));
              },
            );
          }),
        );
      } catch (e) {
        // Handle any unexpected errors during parallel processing
        emit(CreateOrderError('An unexpected error occurred'));
      }
    }
  }

  // Future<FutureOr<void>> _syncOfflineOrderHandler(
  //     SyncOfflineOrdersEvent event, Emitter<OrderState> emit) async {
  //   emit(const CreatingOrder());
  //
  //   ///Checking internet
  //   // bool isInternetAvailable = await InternetConnection().hasInternetAccess;
  //
  //   // if (!isInternetAvailable) {
  //   // Try to load data from Hive if there is no internet connection
  //   // Use Hive to save customers locally
  //   final Box<CartHiveModel> cartBox = Hive.box<CartHiveModel>('cartBox');
  //   if (cartBox.isNotEmpty) {
  //     try {
  //       for (int index = 0; index < cartBox.length; index++) {
  //         log('$index ${cartBox.getAt(index)!.customer.id}');
  //         log(cartBox.length.toString(), name: 'cartBox length from order');
  //         // await Future.wait(
  //         // List.generate(cartBox.length, (index) async {
  //         final result = await _createOrderUseCase(
  //           CreateOrderParams(
  //             cartItem: CartItem(
  //                 products:
  //                     cartBox.getAt(index)!.cartList.toProductModelList()),
  //             totalPrice: cartBox.getAt(index)!.totalPrice,
  //             customer: cartBox.getAt(index)!.customer.toCustomerModel(),
  //           ),
  //         );
  //         cartBox.deleteAt(index);
  //
  //         result.fold(
  //           (failure) {
  //             emit(const CreateOrderError('An unexpected error occurred'));
  //           },
  //           (success) {
  //             emit(CreatedOrderLoaded(success));
  //           },
  //           // );
  //           // }),
  //         ); /*.then((value) => emit(const SyncedAllOfflineOrders()));*/
  //       }
  //     } catch (e) {
  //       // Handle any unexpected errors during parallel processing
  //       emit(CreateOrderError('An unexpected error occurred'));
  //     }
  //   }
  // }

  // }
  String generateUniqueId() {
    // Use current timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Generate a random number
    String random = math.Random().nextInt(1000000).toString();

    // Concatenate timestamp and random number to create a unique ID
    return timestamp + random;
  }
}

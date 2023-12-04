import 'package:get_it/get_it.dart';
import 'package:smart_save/features/home/data/database/home_remote_data_source.dart';
import 'package:smart_save/features/home/data/repository/home_repository_impl.dart';
import 'package:smart_save/features/home/domain/repositories/home_repository.dart';
import 'package:smart_save/features/home/domain/usecases/create_order.dart';
import 'package:smart_save/features/home/domain/usecases/get_products.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:smart_save/features/home/presentation/bloc/product_bloc/product_bloc.dart';

import '../../features/home/domain/usecases/create_customer.dart';
import '../../features/home/domain/usecases/get_customers.dart';
import '../../features/home/domain/usecases/update_customer.dart';
import '../../features/home/presentation/bloc/customer_bloc/customer_bloc.dart';
import '../../features/home/presentation/bloc/order_bloc/order_bloc.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton(() => http.Client())

    //Products

    //App Logic
    ..registerFactory(() => ProductBloc(getProducts: sl()))
    ..registerFactory(() => CustomerBloc(
        getCustomers: sl(), createCustomer: sl(), updateCustomer: sl()))
    //Use cases
    ..registerLazySingleton(() => GetProductsUseCase(sl()))
    ..registerLazySingleton(() => GetCustomersUseCase(sl()))
    ..registerLazySingleton(() => CreateCustomerUseCase(sl()))
    ..registerLazySingleton(() => UpdateCustomerUseCase(sl()))

    //Repositories
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()))
    //Data Sources
    ..registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(sl()))
    ..registerFactory(() => CartBloc())
    ..registerLazySingleton(() => CreateOrderUseCase(sl()))
    ..registerFactory(() => OrderBloc(createOrder: sl()));
}

import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:smart_save/features/home/presentation/bloc/product_bloc/product_event.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/entities/product_hive_model.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../../../core/utils/extenstions.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required GetProductsUseCase getProducts,
  })  : _getProductUseCase = getProducts,
        super(const ProductInitial()) {
    on<ProductFetchEvent>(_productsFetchHandler);
  }

  final GetProductsUseCase _getProductUseCase;

  Future<void> _productsFetchHandler(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    emit(const FetchingProducts());

    ///Checking internet
    bool isInternetAvailable = await InternetConnection().hasInternetAccess;

    if (!isInternetAvailable) {
      log('Internet not available');
      // Try to load data from Hive if there is no internet connection
      final List<Product> cachedProducts = await _loadProductsFromHive();
      if (cachedProducts.isNotEmpty) {
        log('cachedProducts not empty');

        emit(ProductsLoaded(cachedProducts));
      } else {
        emit(const ProductError('No internet connection available.'));
      }
      return;
    }

    // Internet is available, proceed with fetching products
    final result = await _getProductUseCase();
    log(result.toString(), name: 'result login');

    result.fold(
      (failure) async {
        // Try to load data from Hive in case of a failure
        final List<Product> cachedProducts = await _loadProductsFromHive();
        if (cachedProducts.isNotEmpty) {
          emit(ProductsLoaded(cachedProducts));
        } else {
          emit(ProductError(failure.errorMessage));
        }
      },
      (success) {
// Use Hive to save products locally
        _saveProductsToLocal(success.products);

        emit(ProductsLoaded(success.products));
      },
    );
  }
}

Future<void> _saveProductsToLocal(List<Product> products) async {
  log('_saveProductsToLocal');

  try {
    // Open the Hive box before trying to access it
    // Hive.openBox<Product>('productsBox');

    // Use Hive to save products locally
    final Box<ProductHiveModel> productsBox =
        Hive.box<ProductHiveModel>('productsBox');

    log('_saveProductsToLocal productsBox before clear ${productsBox.values.length}');

    // Clear existing data and save new products
    await productsBox.clear();
    // Convert List<Product> to List<ProductHiveModel>
    List<ProductHiveModel> hiveModels = products.toProductHiveModelList();
    if (products.length != productsBox.values.length) {
      productsBox.addAll(hiveModels);
    }
    log('_saveProductsToLocal productsBox after clear ${productsBox.values.length}');
  } catch (e) {
    // Handle Hive error
    log("Error saving products to Hive: $e");
  }
}

Future<List<Product>> _loadProductsFromHive() async {
  log('_loadProductsFromHive');
  try {
    // Open the Hive box before trying to access it
    // Hive.openBox<Product>('productsBox');

    // Load products from Hive
    final Box<ProductHiveModel> productsBox =
        Hive.box<ProductHiveModel>('productsBox');

    log('_loadProductsFromHive productsBox ${productsBox.values.length}');

    List<ProductHiveModel> hiveModels = productsBox.values.toList();

    // Convert List<ProductHiveModel> to List<Product>
    List<Product> products = hiveModels.toProductModelList();

    return products;
  } catch (e) {
    // Handle Hive loading error
    return [];
  }
}

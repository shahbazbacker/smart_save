import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/features/home/domain/entities/cart.dart';

import '../../../domain/entities/customer.dart';
import '../../../domain/entities/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartInitial(
            cartItem: CartItem(products: const []), totalPrice: 0)) {
    on<AddProduct>((event, emit) async {
      emit(CartLoadInProgress(totalPrice: _totalPrice, cartItem: _cartItems));
      await Future.delayed(const Duration(milliseconds: 100));

      event.product.quantity = 1;
      log(event.product.toString(), name: 'event.product');
      log(_cartItems.products.length.toString(),
          name: '_cartItems.products.length before');
      _cartItems.products.add(event.product);
      log(_cartItems.products.length.toString(),
          name: '_cartItems.products.length after');

      double totalPrice = cartTotalCalculate();
      _totalPrice = _totalPrice;

      emit(ProductAdded(
          cartItem: _cartItems,
          totalPrice: totalPrice,
          selectedCustomer: _selectedCustomer));
    });

    on<RemoveProduct>((event, emit) async {
      emit(CartLoadInProgress(totalPrice: _totalPrice, cartItem: _cartItems));
      await Future.delayed(const Duration(milliseconds: 100));

      event.product.quantity = 0;

      _cartItems.products.remove(event.product);

      double totalPrice = cartTotalCalculate();
      _totalPrice = _totalPrice;

      log('removed $totalPrice');

      emit(ProductRemoved(
          cartItem: _cartItems,
          totalPrice: totalPrice,
          selectedCustomer: _selectedCustomer));
    });

    on<IncrementProduct>((event, emit) async {
      emit(CartLoadInProgress(totalPrice: _totalPrice, cartItem: _cartItems));
      await Future.delayed(const Duration(milliseconds: 100));

      // Check if the product is already in the cart
      Product existingProduct = items.products.firstWhere(
        (product) => product == event.product,
        orElse: () => Product.empty(),
      );

      if (existingProduct.id != -1) {
        // Product is already in the cart, so update the quantity
        existingProduct.quantity += 1;
        existingProduct.totalPrice =
            existingProduct.price * existingProduct.quantity;

        // updateQuantity(existingItem, existingItem.quantity + quantity);
      }
      // else {
      //   // Product is not in the cart, so add a new CartItem
      //   addItem(CartItem(
      //       id: items.length + 1,
      //       product: product,
      //       quantity: quantity,
      //       totalPrice: product.price * quantity));
      // }

      double totalPrice = cartTotalCalculate();
      _totalPrice = _totalPrice;

      emit(ProductIncremented(
          cartItem: _cartItems,
          totalPrice: totalPrice,
          selectedCustomer: _selectedCustomer));
    });

    on<DecrementProduct>((event, emit) async {
      emit(CartLoadInProgress(totalPrice: _totalPrice, cartItem: _cartItems));
      await Future.delayed(const Duration(milliseconds: 100));

      // Check if the product is already in the cart
      Product existingProduct = items.products.firstWhere(
        (product) => product == event.product,
        orElse: () => Product.empty(),
      );

      if (existingProduct.id != -1) {
        // Product is already in the cart, so update the quantity
        existingProduct.quantity -= 1;
        existingProduct.totalPrice =
            existingProduct.price * existingProduct.quantity;
      }

      if (existingProduct.quantity == 0) {
        // Update quantity and total price
        _cartItems.products.remove(existingProduct);
      }
      double totalPrice = cartTotalCalculate();
      _totalPrice = _totalPrice;

      emit(ProductDecremented(
          cartItem: _cartItems,
          totalPrice: totalPrice,
          selectedCustomer: _selectedCustomer));
    });

    on<ClearCart>((event, emit) {
      _cartItems.products.clear();

      emit(CartCleared(cartItem: _cartItems, totalPrice: 0));
    });

    on<ClearCartAfterOrderEvent>((event, emit) {
      _cartItems.products.clear();
      _selectedCustomer = Customer.empty();

      emit(CartClearedAfterOrder(cartItem: _cartItems, totalPrice: 0));
    });

    on<GetProductCountInCart>((event, emit) {
      final bool isInCart = isProductInCart(event.product);

      int productCountInCart = isInCart ? getProductQuantity(event.product) : 0;

      double totalPrice = cartTotalCalculate();

      emit(GetProductCountInCartState(
          isInCart: isInCart,
          count: productCountInCart,
          cartItem: _cartItems,
          totalPrice: totalPrice));
    });

    on<AddCustomerToCart>((event, emit) {
      double totalPrice = cartTotalCalculate();
      _selectedCustomer = event.customer;
      emit(CartCustomerAddedState(
          cartItem: _cartItems,
          totalPrice: totalPrice,
          selectedCustomer: event.customer));
    });
  }

  final CartItem _cartItems = CartItem(products: []);
  CartItem get items => _cartItems;

  double _totalPrice = 0;

  double cartTotalCalculate() {
    double total = 0.0;
    for (Product product in _cartItems.products) {
      total += product.quantity * product.price;
    }
    return total;
  }

  bool isProductInCart(Product product) {
    return _cartItems.products.any((product) => product.id == product.id);
  }

  int getProductQuantity(Product product) {
    for (var cartProduct in _cartItems.products) {
      if (cartProduct.id == product.id) {
        return cartProduct.quantity;
      }
    }
    return 0;
  }

  Customer _selectedCustomer = Customer.empty();
}

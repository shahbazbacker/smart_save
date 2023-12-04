import 'package:equatable/equatable.dart';
import 'package:smart_save/features/home/domain/entities/product.dart';

import 'customer.dart';

class CartItem extends Equatable {
  List<Product> products;
  // Customer? customer;

  CartItem({
    required this.products,
    /* this.customer*/
  });

  CartItem.empty() : this(products: []);

  @override
  List<Object> get props => [products];
}

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class FetchingProducts extends ProductState {
  const FetchingProducts();
}

class ProductsLoaded extends ProductState {
  const ProductsLoaded(this.products);

  final List<Product> products;

  @override
  List<Object> get props => products.map((product) => product.id).toList();
}

class ProductError extends ProductState {
  const ProductError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

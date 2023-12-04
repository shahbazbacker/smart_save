import 'package:equatable/equatable.dart';

class ProductResult extends Equatable {
  final int errorCode;
  final List<Product> products;
  final String message;

  const ProductResult({
    required this.errorCode,
    required this.products,
    required this.message,
  });

  @override
  List<Object> get props => [errorCode, products, message];
}

class Product extends Equatable {
  final int id;
  final String name;
  final String image;
  final int price;
  final DateTime createdDate;
  final String createdTime;
  final DateTime modifiedDate;
  final String modifiedTime;
  final bool flag;
  int quantity;
  int totalPrice;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.createdDate,
      required this.createdTime,
      required this.modifiedDate,
      required this.modifiedTime,
      required this.flag,
      this.totalPrice = 0,
      this.quantity = 0});

  Product.empty()
      : this(
            image: '',
            name: '',
            id: -1,
            price: -1,
            createdDate: DateTime.now(),
            createdTime: '',
            modifiedDate: DateTime.now(),
            flag: false,
            modifiedTime: '',
            totalPrice: 0,
            quantity: 0);

  @override
  List<Object> get props => [id, name, price];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate.year.toString().padLeft(4, '0')}-${modifiedDate.month.toString().padLeft(2, '0')}-${modifiedDate.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };

  Map<String, dynamic> toOrderJson() {
    return {
      'product_id': id,
      'quantity': quantity,
      'price': price,
    };
  }

  List<Map<String, dynamic>> listToOrderJson(List<Product> products) {
    return products.map((product) => product.toOrderJson()).toList();
  }
}

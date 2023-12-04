import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_save/core/utils/api_support.dart';
import 'package:smart_save/features/home/domain/entities/product.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_state.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/textstyle_class.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../bloc/cart_bloc/cart_event.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        // mainAxisExtent: size.height * 0.34,
      ),
      itemCount: widget.products.length,
      itemBuilder: (_, index) {
        final productData = widget.products[index];
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 12,
                    offset: Offset(0, 0),
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: Apis.baseUrlForMedia + productData.image,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: 120,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                  // CachedNetworkImage(
                  //   imageUrl: Apis.baseUrlForMedia + productData.image,
                  //   placeholder: (context, url) =>
                  //       const CupertinoActivityIndicator(),
                  //   errorWidget: (context, url, error) =>
                  //       const Icon(Icons.error),
                  //   width: 120,
                  //   height: 80,
                  //   fit: BoxFit.fill,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productData.name,
                        style: TextStyleClass.blackSemiBold14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "\$${productData.price.toStringAsFixed(2)}",
                                style: TextStyleClass.black600SemiBold14,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            VerticalDivider(
                              // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              color: AppColors.grey.withOpacity(0.2),
                              width: 2.0,
                              // height: 23,
                            ),
                            Expanded(
                              child: Container(
                                height: 35.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: getProductQuantity(productData,
                                            state.cartItem.products) ==
                                        0
                                    ? GestureDetector(
                                        onTap: () {
                                          selectedButtonIndex = index;
                                          context
                                              .read<CartBloc>()
                                              .add(AddProduct(productData));
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 3.0),
                                          child: Text(
                                            'Add',
                                            style:
                                                TextStyleClass.whiteSemiBold14,
                                          ),
                                        ),
                                      )
                                    : state is CartLoadInProgress &&
                                            selectedButtonIndex == index
                                        ? const SpinKitWave(
                                            color: Colors.white,
                                            size: 12.0,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: IconButton(
                                                  onPressed: () {
                                                    selectedButtonIndex = index;
                                                    context
                                                        .read<CartBloc>()
                                                        .add(DecrementProduct(
                                                            productData));
                                                    // context.read<CartBloc>().add(
                                                    //     GetProductCountInCart(
                                                    //         product: productData));
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                    color: AppColors.white,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  constraints:
                                                      const BoxConstraints(),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  getProductQuantity(
                                                          productData,
                                                          state.cartItem
                                                              .products)
                                                      .toString(),
                                                  style: TextStyleClass
                                                      .whiteSemiBold14,
                                                ),
                                              ),
                                              Flexible(
                                                child: IconButton(
                                                  onPressed: () {
                                                    selectedButtonIndex = index;

                                                    context
                                                        .read<CartBloc>()
                                                        .add(IncrementProduct(
                                                            productData));
                                                    // context.read<CartBloc>().add(
                                                    //     GetProductCountInCart(
                                                    //         product: productData));
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: AppColors.white,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  constraints:
                                                      const BoxConstraints(),
                                                ),
                                              ),
                                            ],
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// int getProductCount(
//     {required Product product, required List<CartItem> cartItems}) {
//   final cartItemProduct = cartItems.firstWhere(
//       (cartItem) => cartItem ==c artItem,
//       orElse: () => Product.empty());
//
//   return cartItemProduct.quantity;
// }

int getProductQuantity(Product product, List<Product> cartProduct) {
  for (var cartProduct in cartProduct) {
    if (cartProduct.id == product.id) {
      return cartProduct.quantity;
    }
  }
  return 0;
}

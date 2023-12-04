import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/configs/colors.dart';

import 'package:smart_save/features/home/domain/entities/product.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_event.dart';

import '../../../../../configs/icons.dart';
import '../../../../../configs/textstyle_class.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
    required this.cartItemProduct,
    required this.cartItemProductIndex,
  });

  final Product cartItemProduct;
  final int cartItemProductIndex;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) => showDialog(
          context: context,
          builder: ((context) => const DeleteAlertDialog()),
        ),
        onDismissed: (direction) {
          context.read<CartBloc>().add(RemoveProduct(widget.cartItemProduct));
        },
        background: Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(15.0),
          child: IconButton(
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(DecrementProduct(widget.cartItemProduct));
              // context.read<CartBloc>().add(
              //     GetProductCountInCart(
              //         product: productData));
            },
            icon: Image.asset(
              IconClass.deleteIcon,
              color: AppColors.red,
              height: 24.0,
              width: 24.0,
            ),
            padding: const EdgeInsets.all(3),
            constraints: const BoxConstraints(),
          ),
        ),
        // onDismissed: () {},
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 0.0),
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItemProduct.name,
                      style: TextStyleClass.blackBold16,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "\$${widget.cartItemProduct.price.toStringAsFixed(2)}",
                      style: TextStyleClass.black600SemiBold14,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.primaryColor)),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                  DecrementProduct(widget.cartItemProduct));
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 18,
                              color: AppColors.white,
                            ),
                            padding: const EdgeInsets.all(3),
                            constraints: const BoxConstraints(),
                          ),
                          Text(
                            widget.cartItemProduct.quantity.toString(),
                            style: TextStyleClass.whiteSemiBold14,
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                  IncrementProduct(widget.cartItemProduct));
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 22,
                              color: AppColors.white,
                            ),
                            padding: const EdgeInsets.all(3),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: ((context) => const DeleteAlertDialog()),
                        ).then((value) {
                          if (value) {
                            context
                                .read<CartBloc>()
                                .add(RemoveProduct(widget.cartItemProduct));
                          }
                        });
                      },
                      icon: Image.asset(
                        IconClass.deleteIcon,
                        color: AppColors.red,
                        height: 24.0,
                        width: 24.0,
                      ),
                      padding: const EdgeInsets.all(3),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to remove item from the cart'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'))
      ],
    );
  }
}

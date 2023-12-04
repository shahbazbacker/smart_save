import 'package:smart_save/core/utils/extenstions.dart'
    show StringSnackbarExtension, showToast;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:smart_save/features/home/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:smart_save/features/home/presentation/views/order_success.dart';
import 'package:smart_save/features/home/presentation/views/products_screen.dart';
import 'package:smart_save/features/home/presentation/views/widgets/cart_item_card.dart';

import '../../../../common_widgets/elevated_button_custom.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/icons.dart';
import '../../../../configs/textstyle_class.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/product.dart';
import '../bloc/customer_bloc/customer_event.dart';
import '../bloc/order_bloc/order_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.isFromBottomBar}) : super(key: key);
  final bool isFromBottomBar;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartCleared) {
          'Cart Cleared!'.showSnack();
        } else if (state is CartClearedAfterOrder) {
          context.read<CustomerBloc>().add(const ClearSelectedCustomer());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderSuccessScreen()));
        }
      },
      builder: (context, state) {
        final List<Product> cartItemProductList = state.cartItem.products;
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: widget.isFromBottomBar
                    ? IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    : const SizedBox(),
              ),
              title: const Center(
                child: Column(
                  children: [
                    Text(
                      'Your Cart',
                      style: TextStyleClass.blackSemiBold16,
                    ),
                    Text(
                      'Nesto Hypermarket',
                      style: TextStyleClass.blackSemiBold16,
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<CartBloc>().add(const ClearCart());
                    },
                    child: Image.asset(
                      IconClass.menu,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: cartItemProductList.isEmpty /*&& state is CartCleared*/
                ? const Center(
                    child: Text(
                      'Cart is Empty!',
                      style: TextStyleClass.blackExtraBold24,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cartItemProductList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10.0),
                          itemBuilder: (context, index) => CartItemCard(
                            cartItemProductIndex: index,
                            cartItemProduct: cartItemProductList[index],
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            thickness: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 188, 187, 187))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal',
                                    style: TextStyleClass.blackSemiBold14),
                                Text(
                                  "\$${state.totalPrice.toStringAsFixed(2)}",
                                  style: TextStyleClass.blackSemiBold14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 18.0,
                            ),
                            Divider(
                              color: AppColors.grey.withOpacity(0.2),
                              height: 2.0,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 18.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Total (${cartItemProductList.length}Item)',
                                    style: TextStyleClass.blackBold16),
                                Text(
                                  "\$${state.totalPrice.toStringAsFixed(2)}",
                                  style: TextStyleClass.blackBold16,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 18.0,
                            ),
                            BlocConsumer<OrderBloc, OrderState>(
                              listener: (context, orderState) {
                                if (orderState is CreatedOrderLoaded) {
                                  'Order Created Successfully!'.showSnack();
                                  context
                                      .read<CartBloc>()
                                      .add(const ClearCartAfterOrderEvent());
                                } else if (orderState is CreatedOrderInHive) {
                                  'Order Created in Offline Successfully!'
                                      .showSnack();
                                  context
                                      .read<CartBloc>()
                                      .add(const ClearCartAfterOrderEvent());
                                } else if (orderState is CreateOrderError) {
                                  orderState.message.showSnack();
                                }
                              },
                              builder: (context, orderState) {
                                return Row(
                                  children: [
                                    Flexible(
                                      child: ElevatedButtonCustom(
                                          label: 'Order',
                                          padding: 10.0,
                                          borderRadius: 25,
                                          isLoading: state is CreatingOrder,
                                          onTap: () {
                                            if (state.selectedCustomer ==
                                                Customer.empty()) {
                                              'Please Select a Customer!'
                                                  .showSnack();
                                            } else {
                                              context.read<OrderBloc>().add(
                                                  CreateOrderEvent(
                                                      cartItem: state.cartItem,
                                                      totalPrice: state
                                                          .totalPrice
                                                          .toInt(),
                                                      customer: state
                                                          .selectedCustomer!));
                                            }
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Flexible(
                                      child: ElevatedButtonCustom(
                                          label: 'Order & Deliver',
                                          padding: 10.0,
                                          borderRadius: 25,
                                          onTap: () {
                                            // context
                                            //     .read<CartBloc>()
                                            //     .add(const ClearCart());
                                          }),
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          )),
        );
      },
    );
  }
}

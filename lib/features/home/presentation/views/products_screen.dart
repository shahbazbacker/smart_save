import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/configs/textstyle_class.dart';
import 'package:smart_save/features/home/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:smart_save/features/home/presentation/views/cart_screen.dart';
import 'package:smart_save/features/home/presentation/views/widgets/product_grid_view.dart';

import '../../../../common_widgets/elevated_button_custom.dart';
import '../../../../common_widgets/shimmers.dart';
import '../../../../configs/colors.dart';

import '../../../../configs/icons.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/product_bloc/product_event.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductFetchEvent());

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: _homeAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black600),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyleClass.darkGreySemiBold16,
                                  prefixIcon: const Icon(
                                    Icons.search_rounded,
                                    color: AppColors.darkGrey,
                                    size: 28,
                                  ),
                                  suffixIcon: searchController.text.isEmpty
                                      ? IntrinsicWidth(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    IconClass.qrCode,
                                                    height: 26,
                                                    width: 26,
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  VerticalDivider(
                                                    // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    color: AppColors.grey
                                                        .withOpacity(0.2),
                                                    width: 2.0, endIndent: 5,
                                                    indent: 5,
                                                    // height: 23,
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  const Text(
                                                    'Fruits',
                                                    style: TextStyleClass
                                                        .greySemiBold14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.zero),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (state is FetchingProducts)
                          const Expanded(
                            child: ShimmerGridView(),
                          ),
                        if (state is ProductError) const Text('Error'),
                        if (state is ProductsLoaded)
                          Expanded(
                            child: ProductGridView(products: state.products),
                          ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.cartItem.products.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 18.0, right: 18.0),
                  child: ElevatedButtonCustom(
                      label: 'Proceed to Checkout',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CartScreen(isFromBottomBar: false)));
                        // context.read<CartBloc>().add(const ClearCart());
                      }),
                )
              : const SizedBox();
        },
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.cartItem.products.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartScreen(
                                          isFromBottomBar: true)));
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 24,
                              child: Image.asset(
                                IconClass.shoppingBag,
                                color: AppColors.black,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  state.cartItem.products.length.toString(),
                                  style: TextStyleClass.whiteSemiBold10,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Image.asset(
                        IconClass.menu,
                        height: 24,
                        width: 24,
                      ),
                    );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0);
  }
}

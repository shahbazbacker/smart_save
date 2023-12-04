import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/features/home/domain/entities/customer.dart';
import 'package:smart_save/features/home/presentation/views/products_screen.dart';
import 'package:smart_save/features/home/presentation/views/widgets/create_customer_widget.dart';
import 'package:smart_save/features/home/presentation/views/widgets/customer_card.dart';

import '../../../../common_widgets/elevated_button_custom.dart';
import '../../../../common_widgets/shimmers.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/icons.dart';
import '../../../../configs/textstyle_class.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/customer_bloc/customer_bloc.dart';
import '../bloc/customer_bloc/customer_event.dart';
import 'package:smart_save/core/utils/extenstions.dart'
    show StringSnackbarExtension, showToast;

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key, required this.isFromBottomBar})
      : super(key: key);
  final bool isFromBottomBar;

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() => FocusScope.of(context).unfocus());
    context.read<CustomerBloc>().add(const CustomerFetchEvent());

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        // log(state.customersList.length.toString(),
        //     name: 'Customer state customer length');
        if (state is CreatedCustomerLoaded) {
          'Customer Created'.showSnack();
          context.read<CustomerBloc>().add(const CustomerFetchEvent());
        } else if (state is UpdatedCustomerLoaded) {
          'Customer Updated'.showSnack();
          context.read<CustomerBloc>().add(const CustomerFetchEvent());
        } else if (state is CreateCustomerError) {
          log('error creating');
          state.message.showSnack();
        } else if (state is CustomerSelect) {
          log('customer select state');
          log(state.customersList.length.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.secondaryColor,
          appBar: _customerAppBar(),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          hintStyle: TextStyleClass.darkGreyBold16,
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.darkGrey,
                            size: 28,
                          ),
                          suffixIcon: searchController.text.isEmpty
                              ? SizedBox(
                                  width: 70,
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
                                      GestureDetector(
                                        onTap: () {
                                          showCustomerCreateSheet();
                                        },
                                        child: Image.asset(
                                          IconClass.addRounded,
                                          height: 28,
                                          width: 28,
                                        ),
                                      ),
                                    ],
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
                  height: 10,
                ),
                if (state is FetchingCustomers)
                  const Expanded(
                    child: ShimmerList(
                      height: 140,
                    ),
                  ),
                const SizedBox(),
                if (state is CustomersLoaded ||
                    state is CustomerSelect ||
                    state is SelectedCustomerCleared)
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.customersList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10.0),
                        itemBuilder: (context, index) => Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) =>
                                  showCustomerCreateSheet(
                                      state.customersList[index]),
                              onDismissed: (direction) {
                                // context.read<CartBloc>().add(RemoveProduct(widget.cartItemProduct));
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                padding: const EdgeInsets.all(15.0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.blue,
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                              // onDismissed: () {},
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<CustomerBloc>()
                                      .add(CustomerSelectEvent(
                                        customer: state.customersList[index],
                                      ));
                                  context
                                      .read<CartBloc>()
                                      .add(AddCustomerToCart(
                                        state.customersList[index],
                                      ));
                                },
                                child: CustomerCard(
                                  customerIndex: index,
                                  customer: state.customersList[index],
                                  /* isSelected: isSelectedCustomer(
                                        customerList: state.customersList,
                                        customer: state.customersList[index])*/
                                ),
                              ),
                            )),
                  ),
              ],
            ),
          )),
          bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.selectedCustomer != Customer.empty()
                  ? Padding(
                      padding: const EdgeInsets.only(
                          bottom: 18.0, left: 18.0, right: 18.0),
                      child: ElevatedButtonCustom(
                          label: 'Add Products to Cart',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductsScreen()));
                          }),
                    )
                  : const SizedBox();
            },
          ),
        );
      },
    );
  }

  AppBar _customerAppBar() {
    return AppBar(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Image.asset(
              IconClass.menu,
              height: 24,
              width: 24,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0);
  }

  Future<bool> showCustomerCreateSheet([Customer? customer]) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CreateCustomerWidget(customer: customer));
      },
    );
    return Future.value(false);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/icons.dart';
import '../../../../configs/textstyle_class.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';
import 'cart_screen.dart';
import 'customers_screen.dart';
import 'home_screen.dart';
import 'package:smart_save/core/utils/extenstions.dart'
    show StringSnackbarExtension, showToast;

class BottomNavigation extends StatefulWidget {
  final int? index;

  const BottomNavigation({Key? key, this.index}) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      'Press Again to Exit!'.showSnack();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.index != null) {
        setState(() {
          _currentIndex = widget.index!;
        });
      }
    });
  }

  List<Widget> screenList = [
    const HomeScreen(),
    const SizedBox(),
    const CartScreen(
      isFromBottomBar: false,
    ),
    const SizedBox(),
    const CustomersScreen(
      isFromBottomBar: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: onWillPop,
            child: IndexedStack(
              index: _currentIndex,
              children: screenList,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            unselectedItemColor: const Color(0xFF9E9E9E),
            selectedItemColor: AppColors.primaryColor,
            selectedLabelStyle: TextStyleClass.primaryMedium14,
            unselectedLabelStyle: TextStyleClass.greyMedium14,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(IconClass.home,
                      height: 24, color: const Color.fromARGB(255, 34, 34, 34)),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    IconClass.home,
                    height: 25,
                    color: AppColors.primaryColor,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(IconClass.newOrder,
                      height: 22, color: const Color.fromARGB(255, 34, 34, 34)),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    IconClass.newOrder,
                    height: 24,
                    color: AppColors.primaryColor,
                  ),
                ),
                label: 'New Order',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Image.asset(IconClass.cart,
                          height: 25,
                          color: const Color.fromARGB(255, 34, 34, 34)),
                      if (state.cartItem.products.isNotEmpty)
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
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Image.asset(
                        IconClass.cart,
                        height: 25,
                        color: AppColors.primaryColor,
                      ),
                      if (state.cartItem.products.isNotEmpty)
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
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    IconClass.returnOrder,
                    height: 22,
                    color: const Color.fromARGB(255, 34, 34, 34),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    IconClass.returnOrder,
                    height: 24,
                    color: AppColors.primaryColor,
                  ),
                ),
                label: 'Return Order',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    IconClass.customers,
                    height: 22,
                    color: const Color.fromARGB(255, 34, 34, 34),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    IconClass.customers,
                    height: 24,
                    color: AppColors.primaryColor,
                  ),
                ),
                label: 'Customers',
              ),
            ],
          ),
        );
      },
    );
  }
}

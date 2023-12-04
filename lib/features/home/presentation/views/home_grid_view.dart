import 'package:flutter/material.dart';
import 'package:smart_save/features/home/presentation/views/products_screen.dart';

import '../../../../../configs/textstyle_class.dart';
import '../../../../configs/icons.dart';
import 'customers_screen.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 20.0,
          // mainAxisExtent: size.height * 0.3,
          childAspectRatio: 1.2),
      itemCount: homeGridItems.length,
      itemBuilder: (_, index) {
        final homeGridData = homeGridItems[index];
        return GestureDetector(
          onTap: () {
            if (homeGridData.routeName.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => homeGridItems[index].routeName ==
                              'ProductsScreen'
                          ? const ProductsScreen()
                          : homeGridItems[index].routeName == 'CustomersScreen'
                              ? const CustomersScreen(
                                  isFromBottomBar: true,
                                )
                              : const SizedBox()));
            }
          },
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  spreadRadius: 2,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      homeGridData.icon,
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                      homeGridData.label,
                      style: TextStyleClass.blackSemiBold16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeGridItems {
  const HomeGridItems(
      {required this.icon, required this.label, this.routeName = ''});

  final String icon;
  final String label;
  final String routeName;
}

List<HomeGridItems> homeGridItems = [
  const HomeGridItems(
      icon: IconClass.customersOutlined,
      label: 'Customers',
      routeName: 'CustomersScreen'),
  const HomeGridItems(
      icon: IconClass.productBox,
      label: 'Products',
      routeName: 'ProductsScreen'),
  const HomeGridItems(
      icon: IconClass.newOrderPrimary,
      label: 'New Order',
      routeName: 'CustomersScreen'),
  const HomeGridItems(
      icon: IconClass.returnOrderPrimary, label: 'Return Order'),
  const HomeGridItems(icon: IconClass.coinsPrimary, label: 'Add Payment'),
  const HomeGridItems(
      icon: IconClass.todaysOrderPrimary, label: 'Today\'s Order'),
  const HomeGridItems(
      icon: IconClass.todaySummaryPrimary, label: 'Today\'s Summary'),
  const HomeGridItems(icon: IconClass.routePrimary, label: 'Route'),
];

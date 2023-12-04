// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_save/features/home/presentation/views/widgets/star_raing.dart';
//
// import '../../../../common_widgets/elevated_button_custom.dart';
// import '../../../../configs/colors.dart';
// import '../../../../configs/icons.dart';
// import '../../../../configs/textstyle_class.dart';
// import '../../domain/entities/cart.dart';
// import '../../domain/entities/product.dart';
// import '../bloc/cart_bloc/cart_bloc.dart';
// import '../bloc/cart_bloc/cart_event.dart';
// import '../bloc/cart_bloc/cart_state.dart';
//
// class ProductDetailScreen extends StatefulWidget {
//   const ProductDetailScreen({Key? key, required this.product})
//       : super(key: key);
//
//   final Product product;
//
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.network(
//             widget.product.image,
//             width: double.infinity,
//             fit: BoxFit.cover,
//             height: 360,
//           ),
//           Positioned(
//               top: 49,
//               left: 16,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const CircleAvatar(
//                   backgroundColor: AppColors.white,
//                   radius: 24,
//                   child: Icon(
//                     Icons.arrow_back_ios_new,
//                     color: AppColors.black600,
//                   ),
//                 ),
//               )),
//           Positioned(
//               top: 49,
//               right: 16,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const CircleAvatar(
//                   backgroundColor: AppColors.white,
//                   radius: 24,
//                   child: Icon(
//                     CupertinoIcons.heart_fill,
//                     color: Colors.deepOrange,
//                   ),
//                 ),
//               )),
//           Padding(
//             padding:
//                 EdgeInsets.only(top: MediaQuery.of(context).size.height * .4),
//             child: Container(
//               height: MediaQuery.of(context).size.height * .6,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(32),
//                       topRight: Radius.circular(32))),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 32,
//                         ),
//                         Row(
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 widget.product.name,
//                                 style: TextStyleClass.blackBold18
//                                     .apply(color: AppColors.eerieBlack),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10.0,
//                             ),
//                             Text(
//                               "\$${widget.product.price.toStringAsFixed(2)}",
//                               style: TextStyleClass.primaryBold18,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           widget.product.price.toString(),
//                           style: TextStyleClass.darkGreySemiBold14,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           widget.product.,
//                           style: TextStyleClass.darkGreySemiBold14,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           'Size',
//                           style: TextStyleClass.blackBold18
//                               .apply(color: AppColors.eerieBlack),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           children: sizes
//                               .map((s) => Container(
//                                     width: 50,
//                                     height: 50,
//                                     margin: const EdgeInsets.only(right: 20),
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(40),
//                                         border: Border.all(
//                                             width: 0.6,
//                                             color: AppColors.black)),
//                                     child: Center(
//                                       child: Text(
//                                         s,
//                                         style: TextStyleClass.blackSemiBold18,
//                                       ),
//                                     ),
//                                   ))
//                               .toList(),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: BlocBuilder<CartBloc, CartState>(
//           builder: (context, cartState) {
//             return ElevatedButtonCustom(
//                 label: !isProductInCart(widget.product, cartState.cartItem)
//                     ? 'Add to Cart'
//                     : 'Remove From Cart',
//                 icon: IconClass.cart,
//                 onTap: () {
//                   // final List<CartItem> cartList =
//                   //     context.read<CartBloc>().items;
//                   !isProductInCart(widget.product, cartState.cartItem)
//                       ? context.read<CartBloc>().add(AddProduct(widget.product))
//                       : context
//                           .read<CartBloc>()
//                           .add(RemoveProduct(widget.product));
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }
//
// List<String> sizes = ['S', 'M', 'L'];
//
// bool isProductInCart(Product product, List<CartItem> cartItem) {
//   return cartItem.any((item) => item.product == product);
// }

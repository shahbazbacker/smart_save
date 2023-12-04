import 'package:lottie/lottie.dart';
import 'package:smart_save/configs/animations.dart';
import 'package:smart_save/core/utils/extenstions.dart'
    show StringSnackbarExtension, showToast;
import 'package:flutter/material.dart';

import 'package:smart_save/features/home/presentation/views/bottom_navigation.dart';

import '../../../../common_widgets/elevated_button_custom.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/textstyle_class.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()));
              },
            ),
          ),
          title: const Center(
            child: Text(
              'Order Success',
              style: TextStyleClass.blackSemiBold16,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.asset(
                  AnimationClass.success,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Order Completed Successfully',
                style: TextStyleClass.blackBold16,
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButtonCustom(
                  label: 'Go Home',
                  padding: 10.0,
                  borderRadius: 25,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation()));
                  }),
            ],
          ),
        )),
      ),
    );
  }

  Future<bool> onWillPop() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()));
    return Future.value(true);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:smart_save/core/utils/extenstions.dart';
import 'package:smart_save/features/home/presentation/views/home_grid_view.dart';

import '../../../../configs/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../configs/icons.dart';
import '../bloc/order_bloc/order_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InternetStatus lastStatus = InternetStatus.connected;
  @override
  initState() {
    InternetConnection().onStatusChange.listen((InternetStatus status) async {
      if (status != lastStatus) {
        lastStatus = status;
        log('${lastStatus.name.toString()}', name: 'lastStatus');
        log('${status.name.toString()}', name: 'current Status');

        switch (status) {
          case InternetStatus.connected:
            'Internet Connected Now!'.showSnack();
            log('internet connected');
            context.read<OrderBloc>().add(const SyncOfflineOrdersEvent());
            break;
          case InternetStatus.disconnected:
            log('internet not connected');

            'Internet Disconnected Now!'.showSnack();
            break;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _homeAppBar(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: HomeGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                IconClass.fourDots,
                width: 30,
                height: 30,
              ),
            ],
          ),
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
}

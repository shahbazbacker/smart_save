import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_save/features/home/domain/entities/cart_hive_model.dart';
import 'package:smart_save/features/home/domain/entities/product_hive_model.dart';
import 'package:smart_save/features/home/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:smart_save/features/home/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:smart_save/features/home/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:smart_save/features/home/presentation/bloc/product_bloc/product_bloc.dart';

import 'core/services/injection_container.dart';
import 'features/home/domain/entities/customer_hive_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:oktoast/oktoast.dart';

import 'features/home/presentation/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await init();
  final dir = await getApplicationDocumentsDirectory();

  Hive
    ..init(dir.path)
    ..registerAdapter(ProductHiveModelAdapter())
    ..registerAdapter(CustomerHiveModelAdapter())
    ..registerAdapter(CartHiveModelAdapter());
  await Hive.openBox<ProductHiveModel>('productsBox');
  await Hive.openBox<CustomerHiveModel>('customersBox');
  await Hive.openBox<CartHiveModel>('cartBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => sl<ProductBloc>(),
        ),
        BlocProvider<CustomerBloc>(
          create: (context) => sl<CustomerBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => sl<CartBloc>(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => sl<OrderBloc>(),
        )
      ],
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Save',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

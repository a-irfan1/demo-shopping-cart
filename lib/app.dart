import 'package:bloc_fakestore_app/blocs/cart_bloc.dart';
import 'package:bloc_fakestore_app/blocs/store_bloc.dart';
import 'package:bloc_fakestore_app/repository/store_repository.dart';
import 'package:bloc_fakestore_app/screens/cart_page.dart';
import 'package:bloc_fakestore_app/screens/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({required this.storeRepository, super.key});

  final StoreRepository storeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              StoreBloc(storeRepository: storeRepository)..add(StoreStarted()),
        ),
        BlocProvider(
          create: (_) =>
              CartBloc(storeRepository: storeRepository)..add(CartStarted()),
        ),
      ],
      child: MaterialApp(
        title: "Bloc Shopping Cart",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const ProductsPage(),
          '/cart': (_) => const CartPage(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: const ColoredBox(
        color: Colors.deepPurple,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CartList(),
              ),
            ),
            Divider(
              height: 4,
              color: Colors.black,
            ),
            CartTotal(),
          ],
        ),
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    final itemTitleStyle = Theme.of(context).textTheme.titleLarge;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return switch (state) {
          CartLoading() => const CircularProgressIndicator(),
          CartError() => const Text("An error occurred!"),
          CartLoaded() => ListView.separated(
              itemCount: state.cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(
                height: 4,
              ),
              itemBuilder: (context, index) {
                final item = state.cart.items[index];
                return Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ListTile(
                    leading: const Icon(Icons.close),
                    title: Text(
                      item.title,
                      style: itemTitleStyle,
                    ),
                    onLongPress: () {
                      context.read<CartBloc>().add(CartItemRemoved(item));
                    },
                  ),
                );
              },
            ),
        };
      },
    );
  }
}

class CartTotal extends StatelessWidget {
  const CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final largeStyle =
        Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48.0);

    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return switch (state) {
                  CartLoading() => const CircularProgressIndicator(),
                  CartError() => const Text("An error occurred!"),
                  CartLoaded() => Text(
                      "\$${state.cart.totalPrice}",
                      style: largeStyle,
                    )
                };
              },
            ),
            const SizedBox(
              width: 24,
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Not supported yet!")));
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc.dart';
import '../blocs/store_bloc.dart';
import '../models/items.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const StoreAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              return switch (state) {
                StoreLoading() => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                StoreError() => const SliverFillRemaining(
                    child: Text("An error occurred!"),
                  ),
                StoreLoaded() => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => StoreListItem(
                        state.catalog.getByPosition(index),
                      ),
                      childCount: state.catalog.itemNames.length,
                    ),
                  ),
                StoreState() => const Text(""),
              };
            },
          )
        ],
      ),
    );
  }
}

class StoreAppBar extends StatelessWidget {
  const StoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text("Store"),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
        )
      ],
    );
  }
}

class StoreListItem extends StatelessWidget {
  const StoreListItem(this.item, {super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final largeText = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: ColoredBox(
                color: item.color,
              ),
            ),
            const SizedBox(
              width: 24.0,
            ),
            Expanded(
              child: Text(
                item.title,
                style: largeText,
              ),
            ),
            const SizedBox(
              width: 24.0,
            ),
            AddButton(item: item)
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({required this.item, super.key});

  final Item item;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return switch (state) {
          CartLoading() => const CircularProgressIndicator(),
          CartError() => const Text("An error occurred!"),
          CartLoaded() => Builder(
              builder: (context) {
                final inCart = state.cart.items.contains(item);
                return TextButton(
                  style: TextButton.styleFrom(
                    disabledForegroundColor: theme.primaryColor,
                  ),
                  onPressed: inCart
                      ? null
                      : () => context.read<CartBloc>().add(CartItemAdded(item)),
                  child: inCart
                      ? const Icon(
                          Icons.check,
                          semanticLabel: "Added",
                        )
                      : const Text("Add"),
                );
              },
            )
        };
      },
    );
  }
}

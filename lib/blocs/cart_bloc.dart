import 'package:bloc/bloc.dart';
import 'package:bloc_fakestore_app/repository/store_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/cart.dart';
import '../models/items.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.storeRepository}) : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  final StoreRepository storeRepository;

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await storeRepository.loadItems();
      emit(CartLoaded(cart: Cart(items: [...items])));
    } catch (_) {
      emit(CartError());
    }
  }

  Future<void> _onItemAdded(
      CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        storeRepository.addItemToCart(event.item);
        emit(
          CartLoaded(
            cart: Cart(
              items: [...state.cart.items, event.item],
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        storeRepository.removeItemFromCart(event.item);
        emit(
          CartLoaded(
            cart: Cart(
              items: [...state.cart.items]..remove(event.item),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }
}

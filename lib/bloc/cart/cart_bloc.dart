import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>((event, emit) {
      final updated = Map<String, int>.from(state.quantities);
      updated[event.itemId] = (updated[event.itemId] ?? 0) + event.times;
      emit(state.copyWith(quantities: updated));
    });

    on<CartItemRemoved>((event, emit) {
      final updated = Map<String, int>.from(state.quantities);
      final current = updated[event.itemId] ?? 0;
      if (current <= 1) {
        updated.remove(event.itemId);
      } else {
        updated[event.itemId] = current - 1;
      }
      emit(state.copyWith(quantities: updated));
    });

    on<CartQuantitySet>((event, emit) {
      final updated = Map<String, int>.from(state.quantities);
      if (event.quantity <= 0) {
        updated.remove(event.itemId);
      } else {
        updated[event.itemId] = event.quantity;
      }
      emit(state.copyWith(quantities: updated));
    });

    on<CartCleared>((event, emit) => emit(const CartState()));
  }
}

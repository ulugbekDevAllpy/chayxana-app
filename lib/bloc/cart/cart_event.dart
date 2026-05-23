import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.itemId, {this.times = 1});
  final String itemId;
  final int times;
  @override
  List<Object?> get props => [itemId, times];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.itemId);
  final String itemId;
  @override
  List<Object?> get props => [itemId];
}

class CartQuantitySet extends CartEvent {
  const CartQuantitySet(this.itemId, this.quantity);
  final String itemId;
  final int quantity;
  @override
  List<Object?> get props => [itemId, quantity];
}

class CartCleared extends CartEvent {
  const CartCleared();
}

import 'package:equatable/equatable.dart';

import '../../models/menu_item.dart';

class CartState extends Equatable {
  const CartState({this.quantities = const {}});
  final Map<String, int> quantities;

  int quantityOf(String itemId) => quantities[itemId] ?? 0;

  int get itemCount => quantities.values.fold(0, (a, b) => a + b);

  int totalRub(Iterable<MenuItem> catalog) {
    var sum = 0;
    for (final item in catalog) {
      sum += item.priceRub * (quantities[item.id] ?? 0);
    }
    return sum;
  }

  CartState copyWith({Map<String, int>? quantities}) =>
      CartState(quantities: quantities ?? this.quantities);

  @override
  List<Object?> get props => [quantities];
}

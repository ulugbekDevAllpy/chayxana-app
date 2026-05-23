class MenuCategory {
  const MenuCategory({required this.id, required this.name});
  final String id;
  final String name;
}

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.priceRub,
    required this.imageUrl,
    required this.categoryId,
    this.oldPriceRub,
    this.description,
    this.portions = const [],
  });

  final String id;
  final String name;
  final int priceRub;
  final String imageUrl;
  final String categoryId;
  final int? oldPriceRub;
  final String? description;
  final List<Portion> portions;
}

class Portion {
  const Portion({
    required this.pieces,
    required this.weightGram,
    required this.addPriceRub,
  });
  final int pieces;
  final int weightGram;
  final int addPriceRub;
}

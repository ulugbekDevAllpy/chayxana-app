import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';
import '../../models/menu_item.dart';
import '../menu_data.dart' as mock;

class MenuRepository {
  MenuRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<List<MenuCategory>> getCategories() async {
    if (!_client.isConfigured) return mock.menuCategories;
    try {
      final data = await _client.get(Endpoints.categories) as List<dynamic>;
      return data.map((e) => _categoryFromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return mock.menuCategories;
      rethrow;
    }
  }

  Future<List<MenuItem>> getMenuItems({String? categoryId}) async {
    if (!_client.isConfigured) return _localItems(categoryId);
    try {
      final data = await _client.get(
        Endpoints.products,
        query: categoryId != null ? {'category_id': categoryId} : null,
      ) as List<dynamic>;
      return data.map((e) => _itemFromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return _localItems(categoryId);
      rethrow;
    }
  }

  Future<List<MenuItem>> getPopular() async {
    if (!_client.isConfigured) return mock.popularItems;
    try {
      final data = await _client.get(Endpoints.products, query: {'category_id': 'reccom'})
          as List<dynamic>;
      return data.map((e) => _itemFromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return mock.popularItems;
      rethrow;
    }
  }

  Future<MenuItem> getById(String id) async {
    if (!_client.isConfigured) return _findLocal(id);
    try {
      final data = await _client.get(Endpoints.productById(id)) as Map<String, dynamic>;
      return _itemFromJson(data);
    } on ApiException {
      if (ApiConfig.useMockFallback) return _findLocal(id);
      rethrow;
    }
  }

  Future<List<MenuItem>> search(String query) async {
    if (!_client.isConfigured) return _localSearch(query);
    try {
      final data = await _client.get(Endpoints.productsSearch, query: {'search': query})
          as List<dynamic>;
      return data.map((e) => _itemFromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return _localSearch(query);
      rethrow;
    }
  }

  List<MenuItem> _localSearch(String query) {
    final q = query.toLowerCase();
    return mock.menuItems.where((m) => m.name.toLowerCase().contains(q)).toList();
  }

  List<MenuItem> _localItems(String? categoryId) => categoryId == null
      ? mock.menuItems
      : mock.menuItems.where((m) => m.categoryId == categoryId).toList();

  MenuItem _findLocal(String id) =>
      mock.menuItems.firstWhere((m) => m.id == id, orElse: () => mock.menuItems.first);

  MenuCategory _categoryFromJson(Map<String, dynamic> j) => MenuCategory(
        id: j['id'] as String,
        name: j['name'] as String,
      );

  MenuItem _itemFromJson(Map<String, dynamic> j) => MenuItem(
        id: j['id'] as String,
        name: j['name'] as String,
        priceRub: (j['price'] as num).toInt(),
        imageUrl: j['imageUrl'] as String? ?? j['image'] as String? ?? '',
        categoryId: j['categoryId'] as String? ?? j['category'] as String? ?? '',
        oldPriceRub: (j['oldPrice'] as num?)?.toInt(),
        description: j['description'] as String?,
        portions: ((j['portions'] as List?) ?? const [])
            .map((p) => Portion(
                  pieces: (p['pieces'] as num).toInt(),
                  weightGram: (p['weight'] as num).toInt(),
                  addPriceRub: (p['addPrice'] as num).toInt(),
                ))
            .toList(),
      );
}

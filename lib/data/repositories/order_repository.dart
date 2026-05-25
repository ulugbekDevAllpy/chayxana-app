import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class OrderSummary {
  OrderSummary({
    required this.id,
    required this.totalRub,
    required this.dateLabel,
    required this.timeLabel,
    required this.statusLabel,
  });
  final String id;
  final int totalRub;
  final String dateLabel;
  final String timeLabel;
  final String statusLabel;

  factory OrderSummary.fromJson(Map<String, dynamic> j) => OrderSummary(
        id: j['id']?.toString() ?? '',
        totalRub: (j['total'] as num?)?.toInt() ?? 0,
        dateLabel: j['date'] as String? ?? '',
        timeLabel: j['time'] as String? ?? '',
        statusLabel: j['status'] as String? ?? '',
      );
}

class PlaceOrderRequest {
  PlaceOrderRequest({
    required this.items,
    required this.phone,
    required this.address,
    required this.branchId,
    required this.deliveryRange,
    required this.deliveryId,
    this.comment,
    this.promoCode,
    this.entrance,
    this.floor,
    this.room,
    this.name,
    this.deliveryDate,
    this.deliveryTime,
    this.lat,
    this.lng,
  });

  final Map<String, int> items;
  final String phone;
  final String address;
  final String branchId;
  final int deliveryRange;
  final int deliveryId;
  final String? comment;
  final String? promoCode;
  final String? entrance;
  final String? floor;
  final String? room;
  final String? name;
  final String? deliveryDate;
  final String? deliveryTime;
  final String? lat;
  final String? lng;

  Map<String, dynamic> toJson() => {
        'orders': items.entries
            .map((e) => {'product_id': int.tryParse(e.key) ?? e.key, 'quantity': e.value})
            .toList(),
        'phone': phone,
        'address': address,
        'branch': branchId,
        'comment': comment ?? '',
        'delivery_range': deliveryRange,
        'promo': promoCode,
        'entrance': entrance ?? '',
        'floor': floor ?? '',
        'room': room ?? '',
        'name': name ?? '',
        'delivery_date': deliveryDate ?? '',
        'delivery_time': deliveryTime ?? '',
        'delivery_id': deliveryId,
        if (lat != null || lng != null) 'target': {'lang': lng ?? '', 'lat': lat ?? ''},
      };
}

class OrderRepository {
  OrderRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<String> placeOrder(PlaceOrderRequest req) async {
    if (!_client.isConfigured) return _mockId();
    try {
      final data = await _client.post(Endpoints.placeOrder, body: req.toJson())
          as Map<String, dynamic>;
      return data['id']?.toString() ?? _mockId();
    } on ApiException {
      if (ApiConfig.useMockFallback) return _mockId();
      rethrow;
    }
  }

  /// Backend hozircha order history endpoint'i yo'q — mock qaytaradi.
  /// Tayyor bo'lganda Endpoints.placeOrder ga GET so'rovi yuborish mumkin.
  Future<List<OrderSummary>> history() async {
    if (!_client.isConfigured) return _mockHistory();
    try {
      final data = await _client.get(Endpoints.placeOrder) as List<dynamic>;
      return data.map((e) => OrderSummary.fromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return _mockHistory();
      rethrow;
    }
  }

  /// Backend hozircha alohida order detail endpoint'i yo'q — mock.
  Future<Map<String, dynamic>> getOne(String id) async {
    if (ApiConfig.useMockFallback) return _mockOne(id);
    throw ApiException(message: 'Not implemented', endpoint: '/orders/$id');
  }

  /// Backend hozircha order rating endpoint'i yo'q — silent.
  Future<void> rate(String id, {required int stars, List<String>? topics, String? comment}) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/orders/$id/rate');
  }

  /// Backend hozircha cancel order endpoint'i yo'q — silent.
  Future<void> cancel(String id) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/orders/$id/cancel');
  }

  String _mockId() => 'mock-${DateTime.now().millisecondsSinceEpoch}';

  List<OrderSummary> _mockHistory() => List.generate(
        8,
        (i) => OrderSummary(
          id: (1203 - i).toString(),
          totalRub: 1085,
          dateLabel: '18 нояб 2024г',
          timeLabel: '18:01',
          statusLabel: 'Доставлен',
        ),
      );

  Map<String, dynamic> _mockOne(String id) => {
        'id': id,
        'total': 1085,
        'items': [
          {'name': 'Шашлычное ассорти на 4 персоны', 'qty': 1, 'price': 485},
          {'name': 'Шашлычное ассорти на 4 персоны', 'qty': 1, 'price': 485},
        ],
        'address': 'Улица Беруний, 12В, Ташкент',
        'payment': 'Тинькофф',
      };
}

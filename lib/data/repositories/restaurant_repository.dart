import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class RestaurantInfo {
  RestaurantInfo({
    required this.id,
    required this.address,
    required this.city,
    required this.phone,
    required this.hours,
    required this.openUntil,
    required this.kmAway,
    required this.minutesAway,
    required this.photos,
    required this.lat,
    required this.lng,
    required this.open,
  });
  final String id;
  final String address;
  final String city;
  final String phone;
  final String hours;
  final String openUntil;
  final double kmAway;
  final int minutesAway;
  final List<String> photos;
  final double lat;
  final double lng;
  final bool open;

  factory RestaurantInfo.fromJson(Map<String, dynamic> j) => RestaurantInfo(
        id: j['id']?.toString() ?? '',
        address: j['address'] as String? ?? '',
        city: j['city'] as String? ?? '',
        phone: j['phone'] as String? ?? '',
        hours: j['hours'] as String? ?? '',
        openUntil: j['openUntil'] as String? ?? '',
        kmAway: (j['kmAway'] as num?)?.toDouble() ?? 0,
        minutesAway: (j['minutesAway'] as num?)?.toInt() ?? 0,
        photos: ((j['photos'] as List?) ?? const []).map((e) => e.toString()).toList(),
        lat: (j['lat'] as num?)?.toDouble() ?? 0,
        lng: (j['lng'] as num?)?.toDouble() ?? 0,
        open: j['open'] as bool? ?? true,
      );
}

class RestaurantRepository {
  RestaurantRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<List<RestaurantInfo>> list() async {
    if (!_client.isConfigured) return _mock();
    try {
      final data = await _client.get(Endpoints.branches) as List<dynamic>;
      return data.map((e) => RestaurantInfo.fromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return _mock();
      rethrow;
    }
  }

  List<RestaurantInfo> _mock() => [
        RestaurantInfo(
          id: 'r1',
          address: 'Народного Ополчения 47к1с1',
          city: 'Москва',
          phone: '+7 966 99 97 77',
          hours: '10:00 — 00:00',
          openUntil: 'до 00:00',
          kmAway: 1.2,
          minutesAway: 3,
          photos: const [
            'https://picsum.photos/seed/rest1a/400/300',
            'https://picsum.photos/seed/rest1b/400/300',
          ],
          lat: 55.751244,
          lng: 37.618423,
          open: true,
        ),
      ];
}

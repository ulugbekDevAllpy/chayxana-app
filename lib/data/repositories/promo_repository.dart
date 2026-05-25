import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class PromoResult {
  PromoResult({required this.discountRub, required this.valid});
  final int discountRub;
  final bool valid;
}

class PromoRepository {
  PromoRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<PromoResult> apply(String code) async {
    if (!_client.isConfigured) return _mock(code);
    try {
      final data = await _client.post(Endpoints.applyPromo, body: {'code': code})
          as Map<String, dynamic>;
      return PromoResult(
        discountRub: (data['discount'] as num?)?.toInt() ?? 0,
        valid: data['valid'] as bool? ?? false,
      );
    } on ApiException {
      if (ApiConfig.useMockFallback) return _mock(code);
      rethrow;
    }
  }

  PromoResult _mock(String code) =>
      PromoResult(discountRub: code.isNotEmpty ? 300 : 0, valid: code.isNotEmpty);
}

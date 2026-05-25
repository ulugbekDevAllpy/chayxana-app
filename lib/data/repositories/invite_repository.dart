import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class InviteRepository {
  InviteRepository({ApiClient? client});

  /// Backend hozircha invite-code endpoint'i yo'q — mock.
  /// Postman'da register endpoint'ida `referal` maydoni bor — referal kod
  /// foydalanuvchining ID asosida generatsiya qilinishi mumkin.
  Future<String> myCode() async {
    if (ApiConfig.useMockFallback) return 'rfe59w3';
    throw ApiException(message: 'Not implemented', endpoint: '/invite-code');
  }
}

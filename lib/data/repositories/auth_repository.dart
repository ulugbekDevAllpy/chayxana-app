import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class AuthResult {
  AuthResult({required this.token, required this.phone, this.name, this.email});
  final String token;
  final String phone;
  final String? name;
  final String? email;
}

class AuthRepository {
  AuthRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<void> signUp({
    required String phone,
    required String password,
    String? promoCode,
  }) async {
    if (!_client.isConfigured) return;
    try {
      await _client.post(Endpoints.signUp, body: {
        'phone': phone,
        'password': password,
        if (promoCode != null && promoCode.isNotEmpty) 'promoCode': promoCode,
      });
    } on ApiException {
      if (!ApiConfig.useMockFallback) rethrow;
    }
  }

  /// Backend hozircha SMS-code verification endpoint'i yo'q — mock (kod: 12345).
  Future<AuthResult> verifyCode({required String phone, required String code}) async {
    if (code == '12345' || ApiConfig.useMockFallback) return _mockResult(phone);
    throw ApiException(message: 'Wrong code', endpoint: '/verify');
  }

  Future<AuthResult> login({required String phone, required String password}) async {
    if (!_client.isConfigured) return _mockResult(phone);
    try {
      final data = await _client.post(Endpoints.login, body: {
        'phone': phone,
        'password': password,
      }) as Map<String, dynamic>;
      return AuthResult(
        token: data['token'] as String,
        phone: phone,
        name: data['name'] as String?,
        email: data['email'] as String?,
      );
    } on ApiException {
      if (ApiConfig.useMockFallback) return _mockResult(phone);
      rethrow;
    }
  }

  /// Backend hozircha forgot-password endpoint'i yo'q — silent.
  Future<void> forgotPassword(String phone) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/forgot-password');
  }

  /// Backend hozircha reset-password endpoint'i yo'q — silent.
  Future<void> resetPassword({required String phone, required String newPassword}) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/reset-password');
  }

  /// PATCH /user/{id} — backend `multipart/form-data` qabul qiladi (name, surname, mail va h.k.).
  /// Hozircha foydalanuvchi ID kerakli emas — keyinroq /me dan olishingiz mumkin.
  Future<void> updateProfile({String? name, String? email, String? userId}) async {
    if (!_client.isConfigured || userId == null) return;
    try {
      await _client.put(Endpoints.updateUser(userId), body: {
        'name': ?name,
        'mail': ?email,
      });
    } on ApiException {
      if (!ApiConfig.useMockFallback) rethrow;
    }
  }

  /// Backend hozircha logout endpoint'i yo'q — faqat lokal tokenni o'chirish.
  Future<void> logout() async {}

  AuthResult _mockResult(String phone) => AuthResult(
        token: 'mock-token-${DateTime.now().millisecondsSinceEpoch}',
        phone: phone,
      );
}

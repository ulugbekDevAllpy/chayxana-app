import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class UserAddress {
  const UserAddress({
    required this.id,
    required this.text,
    this.entrance,
    this.doorCode,
    this.floor,
    this.apartment,
    this.comment,
  });
  final String id;
  final String text;
  final String? entrance;
  final String? doorCode;
  final String? floor;
  final String? apartment;
  final String? comment;

  factory UserAddress.fromJson(Map<String, dynamic> j) => UserAddress(
        id: j['id']?.toString() ?? '',
        text: j['text'] as String? ?? j['address'] as String? ?? '',
        entrance: j['entrance'] as String?,
        doorCode: j['doorCode'] as String?,
        floor: j['floor'] as String?,
        apartment: j['apartment'] as String?,
        comment: j['comment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        if (entrance != null) 'entrance': entrance,
        if (doorCode != null) 'doorCode': doorCode,
        if (floor != null) 'floor': floor,
        if (apartment != null) 'apartment': apartment,
        if (comment != null) 'comment': comment,
      };
}

class AddressRepository {
  AddressRepository({ApiClient? client});

  /// Backend hozircha alohida addresses endpoint'i yo'q — mock.
  /// Foydalanuvchi manzili PATCH /user/{id} orqali saqlanishi mumkin.
  Future<List<UserAddress>> list() async {
    if (ApiConfig.useMockFallback) return _mock();
    throw ApiException(message: 'Not implemented', endpoint: '/addresses');
  }

  Future<UserAddress> add(UserAddress address) async {
    if (ApiConfig.useMockFallback) return address;
    throw ApiException(message: 'Not implemented', endpoint: '/addresses');
  }

  Future<void> update(UserAddress address) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/addresses/${address.id}');
  }

  Future<void> delete(String id) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/addresses/$id');
  }

  List<UserAddress> _mock() => const [
        UserAddress(id: 'a1', text: 'Народного Ополчения 47к1с1'),
        UserAddress(id: 'a2', text: 'Народного Ополчения 47к1с1'),
        UserAddress(id: 'a3', text: 'Народного Ополчения 47к1с1'),
        UserAddress(id: 'a4', text: 'Народного Ополчения 47к1с1'),
      ];
}

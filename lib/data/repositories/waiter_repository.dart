import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class WaiterCallRequest {
  WaiterCallRequest({required this.tableNumber, required this.bringMenu, required this.bringBill});
  final String tableNumber;
  final bool bringMenu;
  final bool bringBill;

  Map<String, dynamic> toJson() => {
        'table': tableNumber,
        'bringMenu': bringMenu,
        'bringBill': bringBill,
      };
}

class WaiterRepository {
  WaiterRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<List<String>> tables({String? branchId}) async {
    if (!_client.isConfigured) return _mockTables;
    try {
      final data = await _client.get(
        Endpoints.tables,
        query: branchId != null ? {'branch_id': branchId} : null,
      ) as List<dynamic>;
      return data
          .map((e) => (e as Map<String, dynamic>)['table_id']?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return _mockTables;
      rethrow;
    }
  }

  /// Backend hozircha "officiantni chaqirish" endpoint'i yo'q — silent.
  /// `/tables` POST endpoint'i mavjud, lekin u jadval qo'shish uchun.
  Future<void> call(WaiterCallRequest req) async {
    if (ApiConfig.useMockFallback) return;
    throw ApiException(message: 'Not implemented', endpoint: '/waiter/call');
  }

  static const _mockTables = [
    '1', '2', '3', '4', '5', '6А', '6Б', '7', '8', '10', '11',
    '12А', '12Б', '14', '15', '16', '20', 'VIP-1', 'VIP-2',
  ];
}

import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';

class BonusEntry {
  BonusEntry({required this.amount, required this.dateLabel});
  final int amount;
  final String dateLabel;

  factory BonusEntry.fromJson(Map<String, dynamic> j) => BonusEntry(
        amount: (j['amount'] as num).toInt(),
        dateLabel: j['date'] as String? ?? '',
      );
}

class BonusRepository {
  BonusRepository({ApiClient? client});

  /// Backend hozircha bonuses endpoint'i yo'q — mock qaytaradi.
  /// Tayyor bo'lganda /me yoki /user/{id} javobida `bonus_balance` maydonidan oling.
  Future<int> balance() async {
    if (ApiConfig.useMockFallback) return 305;
    throw ApiException(message: 'Not implemented', endpoint: '/bonuses');
  }

  /// Backend hozircha bonus history endpoint'i yo'q — mock.
  Future<List<BonusEntry>> history() async {
    if (ApiConfig.useMockFallback) return _mock();
    throw ApiException(message: 'Not implemented', endpoint: '/bonuses/history');
  }

  List<BonusEntry> _mock() => List.generate(
      8, (_) => BonusEntry(amount: 100, dateLabel: '18 нояб 2024г'));
}

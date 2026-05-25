import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/api_exception.dart';
import '../menu_data.dart' as mock;
import '../menu_data.dart' show StoryCard;

class StoryRepository {
  StoryRepository({ApiClient? client}) : _client = client ?? ApiClient.instance;
  final ApiClient _client;

  Future<List<StoryCard>> list() async {
    if (!_client.isConfigured) return mock.stories;
    try {
      final data = await _client.get(Endpoints.stories) as List<dynamic>;
      return data.map((e) => _fromJson(e as Map<String, dynamic>)).toList();
    } on ApiException {
      if (ApiConfig.useMockFallback) return mock.stories;
      rethrow;
    }
  }

  StoryCard _fromJson(Map<String, dynamic> j) => StoryCard(
        id: j['id']?.toString() ?? '',
        title: j['title'] as String? ?? '',
        coverUrl: j['coverUrl'] as String? ?? j['cover'] as String? ?? '',
        headline: j['headline'] as String? ?? '',
        body: j['body'] as String? ?? '',
        ctaLabel: j['cta'] as String? ?? '',
      );
}

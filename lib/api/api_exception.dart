class ApiException implements Exception {
  ApiException({required this.message, this.statusCode, this.endpoint});

  final String message;
  final int? statusCode;
  final String? endpoint;

  bool get isUnauthorized => statusCode == 401;
  bool get isNotFound => statusCode == 404;
  bool get isServerError => statusCode != null && statusCode! >= 500;
  bool get isNetworkError => statusCode == null;

  @override
  String toString() {
    final code = statusCode != null ? ' [$statusCode]' : '';
    final ep = endpoint != null ? ' ($endpoint)' : '';
    return 'ApiException$code$ep: $message';
  }
}

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class PocketBaseHttpClient extends http.BaseClient {
  final _inner = http.Client();
  late final _client = RetryClient(_inner, retries: 3);
  static bool offline = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (offline) throw Exception('No internet connection');
    debugPrint('request: ${request.method} ${request.url}');
    return _client.send(request);
  }
}

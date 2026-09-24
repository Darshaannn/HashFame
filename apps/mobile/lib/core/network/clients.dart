import 'package:dio/dio.dart';

// Reserved for custom integrations. Supabase platform calls use its SDK.
// No request/response logging interceptor: headers and payloads may contain PII.
Dio createHttpClient() => Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
  ),
);

class PageRequest {
  const PageRequest({this.offset = 0, this.limit = 20})
    : assert(offset >= 0),
      assert(limit > 0 && limit <= 100);
  final int offset;
  final int limit;
}

import 'dart:async';
import 'package:http/http.dart' as http;

class ApiClient {
  static const Duration _timeout = Duration(seconds: 15);

  Future<http.Response> get(String url,
      {Object? body, Map<String, String>? headers}) async {
    return http
        .get(Uri.parse(url), headers: headers)
        .timeout(_timeout);
  }

  Future<http.Response> post(String url,
      {Object? body, Map<String, String>? headers}) async {
    return http
        .post(Uri.parse(url), body: body, headers: headers)
        .timeout(_timeout);
  }

  Future<http.Response> put(String url,
      {Object? body, Map<String, String>? headers}) async {
    return http
        .put(Uri.parse(url), body: body, headers: headers)
        .timeout(_timeout);
  }

  Future<http.Response> delete(String url,
      {Map<String, String>? headers}) async {
    return http
        .delete(Uri.parse(url), headers: headers)
        .timeout(_timeout);
  }
}
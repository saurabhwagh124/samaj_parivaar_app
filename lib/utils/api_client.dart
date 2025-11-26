import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Required for SocketException

import 'package:http/http.dart' as http;
import 'package:samaj_parivaar_app/utils/api_exceptions.dart';

class ApiClient {
  static const Duration _timeout = Duration(seconds: 15);

  // --- PUBLIC METHODS ---

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    return _safeRequest(
      () => http.get(Uri.parse(url), headers: headers).timeout(_timeout),
    );
  }

  Future<dynamic> post(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    return _safeRequest(
      () => http
          .post(Uri.parse(url), body: body, headers: headers)
          .timeout(_timeout),
    );
  }

  Future<dynamic> put(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    return _safeRequest(
      () => http
          .put(Uri.parse(url), body: body, headers: headers)
          .timeout(_timeout),
    );
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    return _safeRequest(
      () => http.delete(Uri.parse(url), headers: headers).timeout(_timeout),
    );
  }

  // --- INTERNAL ERROR HANDLING LOGIC ---

  Future<dynamic> _safeRequest(
    Future<http.Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();
      return _processResponse(response);
    } on SocketException {
      throw NetworkException("No Internet connection");
    } on TimeoutException {
      throw RequestException("Connection timed out. Please try again.");
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        // Success: Return the decoded JSON directly
        // Note: If your API returns plain text, remove jsonDecode
        return responseBody;
      case 400:
        throw BadRequestException(responseBody['message']);
      case 401:
      case 403:
        throw UnauthorizedException(responseBody['message']);
      case 500:
        throw ServerException(responseBody['message']);
      default:
        throw ApiException(
          "Error received with status code: ${response.statusCode}",
        );
    }
  }
}

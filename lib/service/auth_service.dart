import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:samaj_parivaar_app/model/user.dart';
import 'package:samaj_parivaar_app/utils/api_client.dart';
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';

class AuthService extends GetxService {
  final _apiClient = ApiClient();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  Future<User> login(String email, password) async {
    try {
      final payload = {"email": email, "password": password};
      final response = await _apiClient.post(
        ApiEndpoints.loginUrl,
        headers: headers,
        body: jsonEncode(payload),
      );
      final apiRes = jsonDecode(response.body);
      if (apiRes["success"] ?? false) {
        final user = User.fromJson(apiRes["data"]["user"]);
        log(user.toString());
        await LocalStorage.i.saveUser(jsonEncode(user), "current_user");
        await LocalStorage.i.saveToken(apiRes["data"]["token"]);
        return user;
      } else {
        throw Exception(apiRes.message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void logout() {
    LocalStorage.i.clear();
  }

  Future<void> register(String fullName, String email, String password) async {
    try {
      final payload = {
        "fullName": fullName,
        "email": email,
        "password": password,
      };
      final response = await _apiClient.post(ApiEndpoints.registerUrl, headers: headers, body: jsonEncode(payload));
      final apiRes = jsonDecode(response.body);
      if (apiRes["success"] ?? false) {
        return;
      } else {
        throw Exception(apiRes["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

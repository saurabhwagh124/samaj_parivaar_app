import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/user.dart';
import 'package:samaj_parivaar_app/utils/api_client.dart';
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';

class AuthService extends GetxService {
  final _apiClient = ApiClient();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  Future<User> login(String email, password) async {
    final payload = {"email": email, "password": password};
    final response = await _apiClient.post(
      ApiEndpoints.loginUrl,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response["success"] ?? false) {
      final user = User.fromJson(response["data"]["user"]);
      log(user.toString());
      await LocalStorage.i.saveUser(jsonEncode(user), "current_user");
      await LocalStorage.i.saveToken(response["data"]["token"]);
      return user;
    } else {
      throw Exception(response["message"]);
    }
  }

  void logout() {
    LocalStorage.i.clear();
  }

  Future<void> register(String fullName, String email, String password) async {
    final payload = {
      "fullName": fullName,
      "email": email,
      "password": password,
    };
    final response = await _apiClient.post(
      ApiEndpoints.registerUrl,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response["success"] ?? false) {
      return;
    } else {
      throw Exception(response["message"]);
    }
  }

  Future<User> updateUser(User user) async {
    final url = ApiEndpoints.updateUserDetails.replaceAll(
      ":id",
      user.id!.toString(),
    );
    log(jsonEncode(user));
    final response = await _apiClient.put(
      url,
      body: jsonEncode(user),
      headers: headers,
    );

    if (response["success"] ?? false) {
      final updatedUser = User.fromJson(response["data"]);
      await LocalStorage.i.saveUser(jsonEncode(updatedUser), "current_user");
      if (response["data"]["token"] != null) {
        await LocalStorage.i.saveToken(response["data"]["token"]);
      }
      return updatedUser;
    } else {
      throw Exception(response["message"]);
    }
  }
}

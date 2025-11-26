import 'dart:convert';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/model/join_request.dart';
import 'package:samaj_parivaar_app/utils/api_client.dart';
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';

class CommunityService extends GetxService {
  final _apiClient = ApiClient();
  static Map<String, String> headers = {"Content-Type": "application/json"};
  int _page = 1;
  bool _hasNext = true;

  Future<List<CommunityModel>> getCommunities() async {
    final response = await _apiClient.get(
      ApiEndpoints.areaGroupsUrl,
      headers: headers,
    );
    // response is already decoded
    if (response["success"] ?? false) {
      final data = response["data"]["groups"];
      return (data as List)
          .map<CommunityModel>((item) => CommunityModel.fromJson(item))
          .toList();
    } else {
      throw Exception(response["message"]);
    }
  }

  Future<List<CommunityModel>?> loadPage() async {
    if (_hasNext == false) return null;

    final url = '${ApiEndpoints.areaGroupsUrl}?page=$_page&limit=20';
    final response = await _apiClient.get(url);

    final json = response['data'];
    final List<dynamic> items = json['groups'];
    final bool hasNext = json['pages'] > _page;

    if (items.isEmpty && _page == 1) {
      return null;
    } else {
      _hasNext = hasNext;
      if (hasNext) _page++;
      return items.map((e) => CommunityModel.fromJson(e)).toList();
    }
  }

  Future<List<CommunityModel>> getUserCommunities(num id) async {
    final url = ApiEndpoints.groupsOfMembersUrl.replaceAll(
      ":userId",
      id.toString(),
    );
    final response = await _apiClient.get(url, headers: headers);
    if (response["success"] ?? false) {
      final data = response["data"];
      return (data as List)
          .map<CommunityModel>((item) => CommunityModel.fromJson(item))
          .toList();
    } else {
      throw Exception(response["message"]);
    }
  }

  Future<List<CommunityModel>> getAntiUserCommunities(num id) async {
    final url = ApiEndpoints.noGroupsOfMembersUrl.replaceAll(
      ":userId",
      id.toString(),
    );
    final response = await _apiClient.get(url, headers: headers);
    if (response["success"] ?? false) {
      final data = response["data"];
      return (data as List)
          .map<CommunityModel>((item) => CommunityModel.fromJson(item))
          .toList();
    } else {
      throw Exception(response["message"]);
    }
  }

  Future<void> createJoinRequest(JoinRequest payload) async {
    final request = {
      "groupId": payload.groupId,
      "userId": payload.userId,
      "requestMessage": payload.requestMessage,
    };
    final response = await _apiClient.post(
      ApiEndpoints.joinGroupUrl,
      body: jsonEncode(request),
      headers: headers,
    );
    return;
  }
}

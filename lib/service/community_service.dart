import 'dart:convert';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/utils/api_client.dart';
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';

class CommunityService extends GetxService {
  final _apiClient = ApiClient();
  static Map<String, String> headers = {"Content-Type": "application/json"};
  int _page = 1;
  bool _hasNext = true;

  Future<List<CommunityModel>> getCommunities() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.areaGroupsUrl,
        headers: headers,
      );
      final apiRes = jsonDecode(response.body);
      if (apiRes["success"] ?? false) {
        final data = apiRes["data"]["groups"];
        return data
            .map<CommunityModel>((item) => CommunityModel.fromJson(item))
            .toList();
      } else {
        throw Exception(apiRes["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CommunityModel>?> loadPage() async {
    if (_hasNext == false) return null;
    try {
      final url = '${ApiEndpoints.areaGroupsUrl}?page=$_page&limit=20';
      final res = await _apiClient.get(url);
      if (res.statusCode != 200) throw 'HTTP ${res.statusCode}';
      final json = jsonDecode(res.body)['data'];
      final List<dynamic> items = json['groups'];
      final bool hasNext = json['pages'] > _page;
      if (items.isEmpty && _page == 1) {
      } else {
        _hasNext = hasNext;
        if (hasNext) _page++;
        return items.map((e) => CommunityModel.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';

class CommunityService extends GetxService {
  static Map<String, String> headers = {"Content-Type": "application/json"};

  Future<List<CommunityModel>> getCommunities() async {
    try {
      final url = Uri.parse(ApiEndpoints.areaGroupsUrl);
      final response = await http.get(url, headers: headers);
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
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/event_model.dart';
import 'package:samaj_parivaar_app/model/payload/event_payload.dart';
import 'package:samaj_parivaar_app/utils/api_client.dart';
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';

class EventService extends GetxService {
  final _apiClient = ApiClient();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  Future<EventModel> createEvent(EventPayload payload) async {
    final response = await _apiClient.post(
      ApiEndpoints.createEventUrl,
      body: jsonEncode(payload.toJson()),
      headers: headers,
    );
    return EventModel.fromJson(response["data"]);
  }

  Future<List<EventModel>> getEventsByUser(String userId) async {
    final url = ApiEndpoints.getEventByUserIdUrl.replaceAll(
      ":id",
      userId.toString(),
    );
    final response = await _apiClient.get(url);
    final dataList = response["data"] as List;
    return dataList
        .map<EventModel>((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createEventInterest(String eventId, String userId) async {
    final url = ApiEndpoints.createEventInterest;
    final payload = {"eventId": eventId, "userId": userId};
    final response = await _apiClient.post(
      url,
      body: jsonEncode(payload),
      headers: headers,
    );
  }

  Future<void> deleteEventInterest(String eventId, String userId) async {
    final url = ApiEndpoints.deleteEventInterest;
    final payload = {"eventId": eventId, "userId": userId};
    final response = await _apiClient.delete(
      url,
      body: jsonEncode(payload),
      headers: headers,
    );
  }
}

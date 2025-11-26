import 'dart:developer';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/event_model.dart';
import 'package:samaj_parivaar_app/model/payload/event_payload.dart';
import 'package:samaj_parivaar_app/service/event_service.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';

class EventController extends GetxController {
  RxBool isCreateEventLoading = false.obs;
  RxList<EventModel> eventsList = <EventModel>[].obs;
  final service = EventService();

  void createEvent(EventPayload model) async {
    isCreateEventLoading.value = true;
    try {
      final list = eventsList;
      final newEvent = await service.createEvent(model);
      log(newEvent.toString());
      list.add(newEvent);
      eventsList.value = list;
    } catch (e) {
      MySnackBar.showErrorSnackBar("Error creating event", e.toString());
    } finally {
      isCreateEventLoading.value = false;
    }
  }
}

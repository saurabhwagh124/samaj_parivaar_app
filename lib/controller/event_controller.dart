import 'dart:developer';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/event_model.dart';
import 'package:samaj_parivaar_app/model/payload/event_payload.dart';
import 'package:samaj_parivaar_app/service/event_service.dart';
import 'package:samaj_parivaar_app/service/util_service.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';

class EventController extends GetxController {
  final utilService = UtilService();
  RxBool isCreateEventLoading = false.obs;
  RxBool isGetEventsByUserIdLoading = false.obs;
  RxList<EventModel> eventsList = <EventModel>[].obs;
  RxList<num> interestedEventsList = <num>[].obs;
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

  void getEventsByUserId() async {
    isGetEventsByUserIdLoading.value = true;
    try {
      final userId = await utilService.getUserId();
      final list = await service.getEventsByUser(userId.toString());
      eventsList.value = list;
    } catch (e) {
      log(e.toString());
      MySnackBar.showErrorSnackBar(
        "Error fetching events by user",
        e.toString(),
      );
    } finally {
      isGetEventsByUserIdLoading.value = false;
    }
  }

  void createEventInterest(num eventId) async {
    try {
      final userId = await utilService.getUserId();
      await service.createEventInterest(eventId.toString(), userId.toString());
      interestedEventsList.add(eventId);
    } catch (e) {
      log(e.toString());
      MySnackBar.showErrorSnackBar(
        "Error creating event interest",
        e.toString(),
      );
    }
  }

  void deleteEventInterest(num eventId) async {
    try {
      final userId = await utilService.getUserId();
      await service.deleteEventInterest(eventId.toString(), userId.toString());
      interestedEventsList.add(eventId);
    } catch (e) {
      log(e.toString());
      MySnackBar.showErrorSnackBar(
        "Error deleting event interest",
        e.toString(),
      );
    }
  }
}

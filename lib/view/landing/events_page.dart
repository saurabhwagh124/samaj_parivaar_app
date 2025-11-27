import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/event_controller.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/event/event_card.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final controller = Get.find<EventController>();

  @override
  void initState() {
    super.initState();
    if (controller.eventsList.isEmpty) {
      controller.getEventsByUserId();
    }
  }

  void toggleInterested(bool interest, num eventId) {
    if (interest) {
      controller.createEventInterest(eventId);
    } else {
      controller.deleteEventInterest(eventId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        titleText: "Events",
        actionsList: [],
        showLeadingIcon: false,
        center: true,
      ),
      body: Obx(() {
        final list = controller.eventsList;
        final interestedList = controller.interestedEventsList;
        return (controller.isGetEventsByUserIdLoading.value)
            ? Center(child: CircularProgressIndicator())
            : (list.isEmpty)
            ? Center(
                child: Text(
                  "No Events posted yet!",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: MyAppColors.lavender,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final id = list[index].eventId!;
                    return EventCard(
                      key: ValueKey(id),
                      data: list[index],
                      isInterested: interestedList.contains(id),
                      onInterestChanged: (val) => toggleInterested(val, id),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: list.length,
                ),
              );
      }),
    );
  }
}

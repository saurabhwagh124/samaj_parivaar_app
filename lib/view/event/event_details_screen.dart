import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:samaj_parivaar_app/model/event_model.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/utils/date_formatter.dart';
import 'package:samaj_parivaar_app/utils/url_launcher.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';
import 'package:samaj_parivaar_app/widgets/secondary_button.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel data;

  const EventDetailsScreen({super.key, required this.data});

  String isAvailable() {
    log("currentParticipants: ${data.currentParticipants!}");
    log("currentParticipants: ${data.maxParticipants!}");
    if (data.currentParticipants! <= data.maxParticipants! / 2) {
      return "Available";
    } else if (data.currentParticipants! > data.maxParticipants! / 2) {
      return "Filling fast";
    } else {
      return "Full";
    }
  }

  Widget lavenderBorderContainer(Widget child, EdgeInsets padding) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: MyAppColors.lavender),
      ),
      padding: padding,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(titleText: "Event Post", actionsList: []),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyNetworkImage.networkImage(
              data.coverImageUrl ?? "",
              220.h,
              double.infinity,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.eventTitle!,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: MyAppColors.lavender,
                    ),
                  ),
                  lavenderBorderContainer(
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: MyAppColors.lavender,
                          size: 20.sp,
                        ),
                        const SizedBox(width: 10),
                        Text("${data.interestedCount} are interested"),
                        Spacer(),
                        SecondaryButton(
                          newHeight: 40.h,
                          newWidth: 150.w,
                          text: "View Interested",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: MyAppColors.lavender,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ],
                    ),
                    EdgeInsets.all(10.r),
                  ),
                  lavenderBorderContainer(
                    SizedBox(
                      height: 65.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: MyAppColors.lavender,
                            size: 25.sp,
                            weight: 100,
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Column(
                              children: [
                                Text(
                                  "${data.eventDate!.day} ${DateFormat("MMM").format(data.eventDate!)} ${weekDay(data.eventDate!)}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyAppColors.lavender,
                                  ),
                                ),
                                Text(
                                  "${data.eventDate!.hour} ${data.eventDate!.minute}",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          VerticalDivider(
                            color: MyAppColors.dividerGrey,
                            thickness: 2,
                            indent: 3,
                            endIndent: 3,
                          ),
                          Icon(
                            Icons.location_on,
                            color: MyAppColors.lavender,
                            size: 25.sp,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                openMaps(data.eventLocation!);
                              },
                              child: Text(
                                data.eventAddress ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: MyAppColors.lavender,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    EdgeInsets.all(20.r),
                  ),
                  lavenderBorderContainer(
                    Row(
                      children: [
                        MyNetworkImage.networkImageCircleAvatar(
                          18.r,
                          data.creator?.profilePhotoUrl ?? "",
                          BoxFit.cover,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hosted By",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: MyAppColors.lavender,
                              ),
                            ),
                            Text(
                              data.creator?.fullName ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    EdgeInsets.all(15.r),
                  ),
                  lavenderBorderContainer(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: MyAppColors.lavender,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(data.eventDescription ?? ""),
                      ],
                    ),
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  ),
                  if (data.isCancellable ?? false) ...[
                    lavenderBorderContainer(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: double.infinity),
                          Text(
                            "Cancellation Policy",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: MyAppColors.lavender,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(data.cancellationRefundPolicy ?? ""),
                        ],
                      ),
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        padding: EdgeInsets.all(20.r),
        color: Colors.white,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (data.isPaid ?? false)
                    ? Text(
                        "₹ ${data.registrationFee}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        "Free",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                Text(
                  isAvailable(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: MyAppColors.lavender,
                  ),
                ),
              ],
            ),
            Spacer(),
            PrimaryButton(
              newHeight: 45.h,
              newWidth: 145.w,
              text: "Book Now",
              borderRadius: BorderRadius.circular(10.r),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

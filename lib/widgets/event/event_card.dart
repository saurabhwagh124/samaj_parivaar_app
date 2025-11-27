import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:samaj_parivaar_app/model/event_model.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/utils/date_formatter.dart';
import 'package:samaj_parivaar_app/widgets/event/animated_like_button.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';

class EventCard extends StatelessWidget {
  final EventModel data;
  final bool isInterested;
  final ValueChanged<bool> onInterestChanged;

  const EventCard({
    super.key,
    required this.data,
    required this.isInterested,
    required this.onInterestChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MyNetworkImage.networkImage(
                21.r,
                data.coverImageUrl ?? "",
                BoxFit.cover,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.eventTitle ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        timeAgo(data.createdAt!),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.public, size: 10.sp),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Flexible(
            child: Text(
              data.eventDescription ?? "",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              data.coverImageUrl ?? '',
              width: 400,
              height: 250,
              fit: BoxFit.cover, // or BoxFit.fill / contain
              errorBuilder: (ctx, err, stack) => Container(
                width: 400,
                height: 250,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Row(
            children: [
              AnimatedLikeButton(
                isInterested: isInterested,
                onChanged: onInterestChanged,
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: MyAppColors.lavender,
                    size: 20.sp,
                  ),
                  Text(
                    DateFormat("dd MMM").format(data.eventDate!),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: MyAppColors.lavender,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

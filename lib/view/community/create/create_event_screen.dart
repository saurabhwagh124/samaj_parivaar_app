import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:samaj_parivaar_app/controller/event_controller.dart';
import 'package:samaj_parivaar_app/model/payload/event_payload.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/service/util_service.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/utils/app_validators.dart';
import 'package:samaj_parivaar_app/view/location_picker_screen.dart';
import 'package:samaj_parivaar_app/widgets/app_text_form_field.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';
import 'package:samaj_parivaar_app/widgets/secondary_button.dart';

class CreateEventScreen extends StatefulWidget {
  final num groupId;

  const CreateEventScreen({super.key, required this.groupId});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final controller = Get.find<EventController>();
  XFile? mediaImage;
  DateTime? pickedDateTime;
  final totalValue = ValueNotifier<double>(0);
  final isPaidEvent = ValueNotifier<bool>(false);
  final isCancellable = ValueNotifier<bool>(false);
  final showInterested = ValueNotifier<bool>(false);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final upiController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final locationController = TextEditingController();
  final participantsController = TextEditingController();
  final basePriceController = TextEditingController();
  final ticketPriceController = TextEditingController();
  final cancellationPolicyController = TextEditingController();

  LatLng? _selectedLatLng;
  String? _googleMapsLink;

  @override
  void dispose() {
    totalValue.dispose();
    isPaidEvent.dispose();
    isCancellable.dispose();
    upiController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    locationController.dispose();
    participantsController.dispose();
    basePriceController.dispose();
    ticketPriceController.dispose();
    cancellationPolicyController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDateTime != null) {
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        pickedDateTime = DateTime(
          pickedDateTime!.year,
          pickedDateTime!.month,
          pickedDateTime!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        dateTimeController.text = DateFormat(
          'dd MMM yyyy hh:mm a',
        ).format(pickedDateTime!);
      }
    }
  }

  Future<void> _selectLocation(BuildContext context) async {
    final LatLng? result = await Get.to(() => const LocationPickerScreen());

    if (result != null) {
      setState(() {
        _selectedLatLng = result;
        // Create a Google Maps link for redirection
        _googleMapsLink =
            "https://www.google.com/maps/search/?api=1&query=${result.latitude},${result.longitude}";
        log(_googleMapsLink ?? "");
      });

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          result.latitude,
          result.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          // Construct a readable address
          String address =
              "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
          // Removing nulls or empty parts if any
          address = address.replaceAll(RegExp(r', ,'), ', ');
          if (address.startsWith(", ")) address = address.substring(2);

          locationController.text = address;
        } else {
          locationController.text =
              "${result.latitude.toStringAsFixed(5)}, ${result.longitude.toStringAsFixed(5)}";
        }
      } catch (e) {
        // Fallback if geocoding fails
        locationController.text =
            "${result.latitude.toStringAsFixed(5)}, ${result.longitude.toStringAsFixed(5)}";
      }
    }
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: appTheme().colorScheme.iceBlue,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'Crop Image'),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          mediaImage = XFile(croppedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(titleText: "Create Event", actionsList: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mediaImage != null) ...[
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      Image.file(File(mediaImage!.path)),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.delete_forever_outlined),
                            color: Colors.red,
                            onPressed: () {
                              mediaImage = null;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                InkWell(
                  onTap: () {
                    pickImages();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: appTheme().colorScheme.iceBlue,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsRes.ADD_MEDIA,
                          height: 20.r,
                          width: 20.r,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          "Add Media",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                myForm(
                  "Title",
                  "Event title",
                  titleController,
                  myValidator: (val) => AppValidators.required(
                    val,
                    message: "Event title is required",
                  ),
                ),
                myForm(
                  "Event Description",
                  "Event description / details",
                  descriptionController,
                  maxLines: 4,
                  myValidator: (val) => AppValidators.required(
                    val,
                    message: "Event description is required",
                  ),
                ),
                myForm(
                  "Date & Time",
                  "e.g. 22 Nov 9:30 ",
                  dateTimeController,
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  suffixIcon: Icons.date_range,
                  myValidator: (val) => AppValidators.required(
                    val,
                    message: "Event date is required",
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (val) => AppValidators.required(
                        val,
                        message: "Event validator is required",
                      ),
                      controller: locationController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: appTheme().colorScheme.lavender,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: appTheme().colorScheme.lavender,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: appTheme().colorScheme.lavender,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: appTheme().colorScheme.lavender,
                          ),
                        ),
                        hintText: "Select Location",
                        suffixIcon: IconButton(
                          onPressed: () {
                            _selectLocation(context);
                          },
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: appTheme().colorScheme.lavender,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_googleMapsLink != null)
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      "Link: $_googleMapsLink",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ),
                myForm(
                  "Max Participants",
                  "200-300",
                  participantsController,
                  myValidator: (val) => AppValidators.onlyNumbers(val),
                ),
                ValueListenableBuilder(
                  valueListenable: showInterested,
                  builder: (context, value, _) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Show interested people",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: showInterested.value,
                              onChanged: (value) {
                                showInterested.value = value;
                              },
                              activeThumbColor: appTheme().colorScheme.iceBlue,
                              activeTrackColor: appTheme().colorScheme.lavender,
                              inactiveTrackColor:
                                  appTheme().colorScheme.iceBlue,
                              inactiveThumbColor:
                                  appTheme().colorScheme.lavender,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isCancellable,
                  builder: (context, value, _) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Is event cancellable/refundable",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: value,
                              onChanged: (value) {
                                isCancellable.value = value;
                              },
                              activeThumbColor: appTheme().colorScheme.iceBlue,
                              activeTrackColor: appTheme().colorScheme.lavender,
                              inactiveTrackColor:
                                  appTheme().colorScheme.iceBlue,
                              inactiveThumbColor:
                                  appTheme().colorScheme.lavender,
                            ),
                          ],
                        ),
                        if (isCancellable.value) ...[
                          myForm(
                            "Cancellations & Refund Policy",
                            "",
                            cancellationPolicyController,
                            maxLines: 2,
                            myValidator: (val) => AppValidators.required(
                              val,
                              message: "Cancellation policy is required",
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                  valueListenable: isPaidEvent,
                  builder: (context, isPaid, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Paid Event",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: isPaid,
                              onChanged: (value) {
                                isPaidEvent.value = value;
                                if (!value) {
                                  basePriceController.clear();
                                  totalValue.value = 0;
                                }
                              },
                              activeThumbColor: appTheme().colorScheme.iceBlue,
                              activeTrackColor: appTheme().colorScheme.lavender,
                              inactiveTrackColor:
                                  appTheme().colorScheme.iceBlue,
                              inactiveThumbColor:
                                  appTheme().colorScheme.lavender,
                            ),
                          ],
                        ),
                        if (isPaid) ...[
                          const SizedBox(height: 20),
                          myForm(
                            "Upi Id",
                            "abc123@axl",
                            upiController,
                            myValidator: (val) => AppValidators.upiAddress(val),
                          ),
                          Row(
                            children: [
                              Text(
                                "Base Amount",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: appTheme().colorScheme.textGrey2,
                                ),
                              ),
                              Spacer(flex: 3),
                              Text("₹"),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  validator: (val) =>
                                      AppValidators.onlyNumbers(val),
                                  controller: basePriceController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      totalValue.value = 0.00;
                                      return;
                                    }
                                    final temp = double.tryParse(value) ?? 0.0;
                                    totalValue.value = temp;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Text(
                                "Total Amount (per person)",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: appTheme().colorScheme.lavender,
                                ),
                              ),
                              Spacer(),
                              ValueListenableBuilder(
                                valueListenable: totalValue,
                                builder: (context, value, _) => Text(
                                  "₹${totalValue.value.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: appTheme().colorScheme.lavender,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (mediaImage == null) {
                          MySnackBar.showErrorSnackBar(
                            "Add Media Image",
                            "media image is required",
                          );
                          return;
                        }
                        final url = await UtilService().uploadImage(
                          File(mediaImage!.path),
                        );
                        if (url == null) {
                          return;
                        }
                        final userId = await UtilService().getUserId();
                        final payload = EventPayload(
                          groupId: widget.groupId,
                          createdBy: userId,
                          eventTitle: titleController.text,
                          eventDescription: descriptionController.text,
                          interestedCount: 0,
                          eventDate: pickedDateTime!,
                          eventLocation: _googleMapsLink,
                          eventAddress: locationController.text,
                          registrationFee: isPaidEvent.value
                              ? basePriceController.text
                              : null,
                          maxParticipants: int.parse(
                            participantsController.text,
                          ),
                          currentParticipants: 0,
                          coverImageUrl: url,
                          eventStatus: "open",
                          isPaid: isPaidEvent.value,
                          isCancellable: isCancellable.value,
                          eventInterested: 0,
                          showInterested: showInterested.value,
                        );
                        controller.createEvent(payload);
                      }
                      return;
                    },
                    child: SecondaryButton(
                      newHeight: 35.h,
                      newWidth: 165.w,
                      text: "Continue",
                      borderRadius: BorderRadius.circular(12.r),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: appTheme().colorScheme.lavender,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myForm(
    String myText,
    String hintText,
    TextEditingController myController, {
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
    Widget? prefixIcon,
    String? Function(String?)? myValidator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          myText,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        AppTextFormField(
          validator: myValidator,
          hintText: hintText,
          controller: myController,
          myFillColor: Colors.white,
          myBorderColor: appTheme().colorScheme.lavender,
          radius: BorderRadius.circular(10.r),
          myMaxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/app_text_form_field.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/secondary_button.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final gstValue = ValueNotifier<double>(0);
  final totalValue = ValueNotifier<double>(0);
  final isPaidEvent = ValueNotifier<bool>(false);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final locationController = TextEditingController();
  final participantsController = TextEditingController();
  final basePriceController = TextEditingController();
  final ticketPriceController = TextEditingController();
  final cancellationPolicyController = TextEditingController();
  final mediaList = <XFile>[];

  LatLng? _selectedLatLng;
  String? _googleMapsLink;

  @override
  void dispose() {
    gstValue.dispose();
    totalValue.dispose();
    isPaidEvent.dispose();
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
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        dateTimeController.text = DateFormat(
          'dd MMM yyyy hh:mm a',
        ).format(fullDateTime);
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
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        mediaList.addAll(pickedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(titleText: "Create Event", actionsList: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (mediaList.isNotEmpty)
                  ? SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            fit: StackFit.loose,
                            children: [
                              Image.file(File(mediaList[index].path)),
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
                                      mediaList.removeAt(index);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: mediaList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20),
                      ),
                    )
                  : SizedBox.shrink(),
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
              myForm("Title", "Event title", titleController),
              myForm(
                "Event Description",
                "Event description / details",
                descriptionController,
                maxLines: 4,
              ),
              myForm(
                "Date & Time",
                "e.g. 22 Nov 9:30 ",
                dateTimeController,
                readOnly: true,
                onTap: () => _selectDateTime(context),
                suffixIcon: Icons.date_range,
              ),
              myForm(
                "Location",
                "Select location",
                locationController,
                readOnly: false,
                onTap: () => _selectLocation(context),
                suffixIcon: Icons.location_on,
              ),
              if (_googleMapsLink != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Link: $_googleMapsLink",
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                  ),
                ),
              myForm("Max Participants", "200-300", participantsController),
              myForm(
                "Cancellations & Refund Policy",
                "",
                cancellationPolicyController,
                maxLines: 2,
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
                                gstValue.value = 0;
                                totalValue.value = 0;
                              }
                            },
                            activeThumbColor: appTheme().colorScheme.iceBlue,
                            activeTrackColor: appTheme().colorScheme.lavender,
                            inactiveTrackColor: appTheme().colorScheme.iceBlue,
                            inactiveThumbColor: appTheme().colorScheme.lavender,
                          ),
                        ],
                      ),
                      if (isPaid) ...[
                        const SizedBox(height: 20),
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
                                controller: basePriceController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    gstValue.value = 0.00;
                                    totalValue.value = 0.00;
                                    return;
                                  }
                                  num temp = int.tryParse(value) ?? 0;
                                  gstValue.value = temp * 0.09;
                                  totalValue.value =
                                      temp + (gstValue.value * 2);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder(
                          valueListenable: gstValue,
                          builder: (context, value, _) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text("Central GST(@ 9%)"),
                                    Spacer(),
                                    Text(
                                      "₹${gstValue.value.toStringAsFixed(2)}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("State GST(@ 9%)"),
                                    Spacer(),
                                    Text(
                                      "₹${gstValue.value.toStringAsFixed(2)}",
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              "Total Amount",
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
              const SizedBox(height: 100),
            ],
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

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? mapController;
  LatLng _defaultPosition = const LatLng(18.5204, 73.8567); // Pune
  LatLng? _pickedLocation;
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );

      if (mounted) {
        setState(() {
          _defaultPosition = LatLng(position.latitude, position.longitude);
          _isLoading = false;
        });

        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _defaultPosition, zoom: 15),
          ),
        );
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
      _markers = {
        Marker(markerId: const MarkerId('picked_location'), position: position),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location"),
        backgroundColor: appTheme().colorScheme.iceBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: appTheme().colorScheme.lavender),
            onPressed: () {
              if (_pickedLocation != null) {
                Get.back(result: _pickedLocation);
              } else {
                Get.snackbar(
                  "Select Location",
                  "Please tap on map to select a location",
                );
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _defaultPosition,
                zoom: 12.0,
              ),
              onTap: _onTap,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}

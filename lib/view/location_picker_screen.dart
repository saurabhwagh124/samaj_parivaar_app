import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final _searchController = TextEditingController();
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appTheme().colorScheme.lavender,
            size: 20.sp,
          ),
        ),
        title: Text(
          "Pick Location",
          style: appTheme().textTheme.headlineSmall?.copyWith(
            color: appTheme().colorScheme.lavender,
          ),
        ),
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
          : Stack(
              children: [
                GoogleMap(
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
                Positioned(
                  top: 50, // Adjust for status bar
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: _searchController,
                      googleAPIKey: "AIzaSyD8Sw2EuV_3UIlxtRQxwJpnPT30KSe38v4",
                      inputDecoration: const InputDecoration(
                        hintText: "Search your location",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      debounceTime: 800,
                      countries: ["in"],
                      isLatLngRequired: true,
                      // IMPORTANT: We need coords to move camera
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        // This is called when user selects a result

                        // 1. Get coordinates
                        final lat = double.parse(prediction.lat!);
                        final lng = double.parse(prediction.lng!);

                        // 2. Move the map camera
                        mapController?.animateCamera(
                          CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14),
                        );

                        // 3. Add a marker
                        setState(() {
                          _pickedLocation = LatLng(lat, lng);
                          _markers.clear();
                          _markers.add(
                            Marker(
                              markerId: const MarkerId("selected_place"),
                              position: LatLng(lat, lng),
                              infoWindow: InfoWindow(
                                title: prediction.description,
                              ),
                            ),
                          );
                        });
                      },
                      itemClick: (Prediction prediction) {
                        _searchController.text = prediction.description ?? "";
                        _searchController
                            .selection = TextSelection.fromPosition(
                          TextPosition(offset: _searchController.text.length),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

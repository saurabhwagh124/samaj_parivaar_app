import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final Color _fillColor = const Color(0xFFE3F2FD);
  final Color _iconColor = const Color(0xFF673AB7);
  XFile? profileImage;

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8.h),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: maxLines > 1 ? 16.0 : 12.0, // Taller padding for Bio
              horizontal: 12.0,
            ),
            filled: true,
            fillColor: _fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none, // Remove border
            ),
            hintText: '', // Placeholder can be added here if needed
          ),
        ),
        SizedBox(height: 24.h), // Spacing after each field
      ],
    );
  }

  Future<void> getImages() async {
    final picker = ImagePicker();
    profileImage ??= await picker.pickImage(source: ImageSource.camera);
    if (profileImage != null) {
      final temp = await picker.pickImage(source: ImageSource.camera);
      if (temp != null) {
        profileImage = temp;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  // Profile placeholder image
                  CircleAvatar(
                    radius: 60.r,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: FileImage(File(profileImage?.path ?? "")),
                  ),
                  // Camera Icon
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        getImages();
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: _iconColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.photo_camera_outlined,
                          color: _iconColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
            Text(
              'Basic Detail',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24.h),
            _buildTextField(
              label: 'Full Name',
              controller: _fullNameController,
            ),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextField(label: 'Address', controller: _addressController),
            _buildTextField(
              label: 'Bio',
              controller: _bioController,
              maxLines: 5,
            ),
            _buildTextField(label: 'Area', controller: _areaController),
            _buildTextField(label: 'Upi id', controller: _upiController),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: _iconColor,
        onPressed: () {},
        child: Icon(Icons.arrow_forward, color: Colors.white, size: 30.sp),
      ),
    );
  }
}

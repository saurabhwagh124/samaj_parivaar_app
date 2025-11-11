import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage = 'English'; // Set default as English

  final List<String> _languages = ['English', 'हिन्दी', 'मराठी'];

  final Color _primaryColor = appTheme().colorScheme.lavender; // Deep Purple
  final Color _selectedTileColor = appTheme().colorScheme.lavender;
  final Color _unselectedTileColor = Colors.white;
  final Color _borderColor = appTheme().colorScheme.lavender;

  Widget _buildLanguageTile(String language) {
    bool isSelected = _selectedLanguage == language;

    return Container(
      margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
      height: 61.h,
      width: 283.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? _selectedTileColor : _unselectedTileColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isSelected ? _selectedTileColor : _borderColor,
          width: 1.5,
        ),
      ),
      child: RadioListTile<String>(
        value: language,
        groupValue: _selectedLanguage,
        onChanged: (String? value) {
          setState(() {
            _selectedLanguage = value;
          });
        },
        title: Text(
          language,
          style: TextStyle(
            color: isSelected
                ? _unselectedTileColor
                : appTheme().colorScheme.lavender,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        activeColor: isSelected ? _unselectedTileColor : _primaryColor,
        visualDensity: VisualDensity.compact,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.h),
            Text(
              'Choose your Language',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: _primaryColor,
              ),
            ),

            SizedBox(height: 40.h),

            ..._languages.map(_buildLanguageTile),

            SizedBox(height: 20.h),
            Center(
              child: Text(
                'Your language preference can be changed\n at any time in Settings',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 70.h),
            Center(
              child: PrimaryButton(
                newHeight: 56.h,
                newWidth: 168.w,
                text: "Continue",
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

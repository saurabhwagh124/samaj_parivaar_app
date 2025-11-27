import 'package:flutter/material.dart';

extension AppColors on ColorScheme {
  Color get iceBlue => const Color(0xFFCDE8FD); // ← #CDE8FD
  Color get lavender => const Color(0xFF4F51C0); // ← #4F51C0
  Color get grey1 => const Color(0xFFD9D9D9);

  Color get textGrey => const Color(0xFFAFAAAA);

  Color get textGrey2 => const Color(0xFFB1AAAA);
}

ThemeData appTheme() {
  const iceBlue = Color(0xFFCDE8FD);
  const lavender = Color(0xFF4F51C0);

  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',

    colorScheme: ColorScheme.fromSeed(
      seedColor: lavender,
      primary: lavender,
      secondary: iceBlue,
      surface: Colors.white,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    ).apply(fontFamily: 'Inter'),
  );
}

class MyAppColors {
  static const iceBlue = Color(0xFFCDE8FD);
  static const lavender = Color(0xFF4F51C0);
  static const grey1 = Color(0xFFD9D9D9);
  static const textGrey = Color(0xFFAFAAAA);
  static const textGrey2 = Color(0xFFB1AAAA);
}

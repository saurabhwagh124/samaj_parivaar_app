import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

/// Universal TextFormField ----------------------------------------------------
/// - normal or password (toggle obscure)
/// - optional prefix / suffix icons
/// - optional validator, keyboardType, textInputAction, onFieldSubmitted
class AppTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueNotifier<bool>? obscureNotifier; // true → obscure
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureNotifier,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool?>(
      // rebuild only when obscure state changes
      valueListenable: obscureNotifier ?? ValueNotifier<bool?>(null),
      builder: (_, obscureValue, __) {
        final isObscure = obscureValue ?? false;

        return TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          focusNode: focusNode,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            filled: true,
            fillColor: appTheme().colorScheme.iceBlue,
            hintText: hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.black,
              fontSize: 18.sp,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: theme.colorScheme.primary),
            suffixIcon: _buildSuffixIcon(isObscure),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: theme.textTheme.bodyLarge,
          cursorColor: theme.colorScheme.primary,
        );
      },
    );
  }

  /* --------------------------------------------------------------------------
   * Builds the suffix icon:
   * - if obscureNotifier is supplied → eye / eye-off toggle
   * - else if caller supplied suffixIcon → use it
   * - else → null (no suffix)
   * -------------------------------------------------------------------------- */
  Widget? _buildSuffixIcon(bool isObscure) {
    if (obscureNotifier != null) {
      return IconButton(
        icon: Icon(
          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
        color: appTheme().colorScheme.lavender,
        onPressed: () => obscureNotifier!.value = !isObscure,
      );
    }
    if (suffixIcon != null) {
      return Icon(suffixIcon, color: appTheme().colorScheme.lavender);
    }
    return null;
  }
}

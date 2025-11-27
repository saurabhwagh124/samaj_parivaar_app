import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

/// Universal TextFormField ----------------------------------------------------
/// - normal or password (toggle obscure)
/// - optional prefix / suffix icons
/// - optional validator, keyboardType, textInputAction, onFieldSubmitted
class AppTextFormField extends StatelessWidget {
  final Function(String)? onChangeFunction;
  final String hintText;
  final Color? myFillColor;
  final Color? myBorderColor;
  final int myMaxLines;
  final TextStyle? hintTextStyle;
  final BorderRadius? radius;
  final TextEditingController controller;
  final ValueNotifier<bool>? obscureNotifier; // true → obscure
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextFormField({
    super.key,
    this.onChangeFunction,
    required this.hintText,
    this.myFillColor,
    this.myBorderColor,
    this.myMaxLines = 1,
    this.hintTextStyle,
    required this.controller,
    this.radius,
    this.obscureNotifier,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
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
          maxLines: myMaxLines,
          onChanged: onChangeFunction,
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          focusNode: focusNode,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: (myFillColor != null)
                ? myFillColor
                : MyAppColors.iceBlue,
            hintText: hintText,
            hintStyle: (hintTextStyle != null)
                ? hintTextStyle
                : theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
            prefixIcon: prefixIcon,
            suffixIcon: _buildSuffixIcon(isObscure),
            border: OutlineInputBorder(
              borderRadius: (radius != null)
                  ? radius!
                  : BorderRadius.circular(30),
              borderSide: BorderSide(
                color: (myBorderColor != null)
                    ? myBorderColor!
                    : Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: (radius != null)
                  ? radius!
                  : BorderRadius.circular(30),
              borderSide: BorderSide(
                color: (myBorderColor != null)
                    ? myBorderColor!
                    : Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: (radius != null)
                  ? radius!
                  : BorderRadius.circular(30),
              borderSide: BorderSide(
                color: (myBorderColor != null)
                    ? myBorderColor!
                    : Colors.transparent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: (radius != null)
                  ? radius!
                  : BorderRadius.circular(30),
              borderSide: BorderSide(
                color: (myBorderColor != null)
                    ? myBorderColor!
                    : Colors.transparent,
              ),
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
        // color: MyAppColors.lavender,
        onPressed: () => obscureNotifier!.value = !isObscure,
      );
    }
    if (suffixIcon != null) {
      return Icon(suffixIcon, color: MyAppColors.lavender);
    }
    return null;
  }
}

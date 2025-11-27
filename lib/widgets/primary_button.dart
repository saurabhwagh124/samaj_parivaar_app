import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final double newHeight;
  final double newWidth;
  final String text;
  final BorderRadius borderRadius;
  final TextStyle? style;

  const PrimaryButton({
    super.key,
    required this.newHeight,
    required this.newWidth,
    required this.text,
    required this.borderRadius,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: newHeight,
      width: newWidth,
      decoration: BoxDecoration(
        color: MyAppColors.lavender,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: (style != null)
            ? style
            : appTheme().textTheme.headlineSmall?.copyWith(color: Colors.white),
      ),
    );
  }
}

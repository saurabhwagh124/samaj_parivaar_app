import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final double newHeight;
  final double newWidth;
  final String text;
  final TextStyle? style;
  final BoxBorder? newBorder;
  final BorderRadius borderRadius;
  final List<BoxShadow>? newShadow;

  const SecondaryButton({
    super.key,
    required this.newHeight,
    required this.newWidth,
    this.style,
    this.newBorder,
    required this.text,
    required this.borderRadius,
    this.newShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: newHeight,
      width: newWidth,
      decoration: BoxDecoration(
        color: appTheme().colorScheme.iceBlue,
        borderRadius: borderRadius,
        border: newBorder,
        boxShadow: newShadow,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: (style != null)
            ? style
            : appTheme().textTheme.headlineSmall?.copyWith(color: Colors.black),
      ),
    );
  }
}

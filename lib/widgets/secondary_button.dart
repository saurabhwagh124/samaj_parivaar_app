import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final double newHeight;
  final double newWidth;
  final String text;
  final BorderRadius borderRadius;

  const SecondaryButton({
    super.key,
    required this.newHeight,
    required this.newWidth,
    required this.text,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: newHeight,
      width: newWidth,
      decoration: BoxDecoration(
        color: appTheme().colorScheme.iceBlue,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: appTheme().textTheme.headlineSmall?.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}

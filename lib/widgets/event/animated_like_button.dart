import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

typedef InterestCallback = void Function(bool isInterested);

class AnimatedLikeButton extends StatefulWidget {
  final bool isInterested; // seed from parent
  final InterestCallback onChanged; // parent receives new state

  const AnimatedLikeButton({
    super.key,
    required this.isInterested,
    required this.onChanged,
  });

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton> {
  late bool _isInterested;

  final Color _iceBlue = MyAppColors.iceBlue;
  final Color _lavender = MyAppColors.lavender;
  static const Duration _animationDuration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _isInterested = widget.isInterested;
  }

  @override
  void didUpdateWidget(covariant AnimatedLikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isInterested != widget.isInterested) {
      _isInterested = widget.isInterested; // external state changed
    }
  }

  void _toggleInterested() {
    setState(() => _isInterested = !_isInterested);
    widget.onChanged(_isInterested); // <-- parent decides what to do
  }

  @override
  Widget build(BuildContext context) {
    final Color buttonBackgroundColor = !_isInterested ? _iceBlue : _iceBlue;
    final Color buttonBorderColor = !_isInterested ? _iceBlue : _lavender;
    final Color iconColor = _lavender;
    final Color textColor = _lavender;

    return GestureDetector(
      onTap: _toggleInterested,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: buttonBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedSwitcher(
              duration: _animationDuration,
              switchInCurve: Curves.bounceInOut,
              switchOutCurve: Curves.easeInBack,
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                _isInterested ? Icons.thumb_up : Icons.thumb_up_outlined,
                key: ValueKey<bool>(_isInterested),
                color: iconColor,
                size: 15.sp,
              ),
            ),
            const SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
              child: const Text('Interested'),
            ),
          ],
        ),
      ),
    );
  }
}

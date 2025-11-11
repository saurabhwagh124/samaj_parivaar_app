import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget(this.msg, {super.key});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(msg, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

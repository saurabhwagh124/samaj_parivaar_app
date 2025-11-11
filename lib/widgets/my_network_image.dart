import 'package:flutter/material.dart';

class MyNetworkImage {
  static Widget networkImage(double size, String url, BoxFit fit) {
    return CircleAvatar(
      radius: size,
      foregroundImage: NetworkImage(url),
      backgroundColor: Colors.grey[200],
      onForegroundImageError: (context, stackTrace) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }
}
